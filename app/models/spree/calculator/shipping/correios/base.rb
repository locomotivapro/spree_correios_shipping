require 'digest/md5'
require 'ostruct'
require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    module Correios
      class Base < ShippingCalculator

        def available?(package)
          is_package_shippable?(package)

          !compute(package).nil?
        rescue Spree::ShippingError
          false
        end

        def self.description
          raise StandardError, "Subclass must implement description"
        end

        def self.service_code
          raise StandardError, "Subclass must implement service code"
        end

        def compute_package(package)
          order = package.order
          stock_location = package.stock_location

          origin = build_location(stock_location)
          destination = build_location(order.ship_address)
          service_code = self.class.service_code

          rates_result = retrieve_rates_from_cache(package, origin, destination)

          return nil if rates_result.kind_of?(Spree::ShippingError)
          return nil if rates_result.empty?
          return nil unless rates_result.is_a?(Hash)
          rate = rates_result[service_code][:price]

          return nil unless rate
          return nil if rate.to_f == 0.0

          return rate
        end

        private
        def is_package_shippable?(package)
          if Spree::CorreiosShipping::Config[:split_shipments]
            heavy_items = package.contents.select { |content_item| content_item.variant.weight.to_f >= max_allowed_weight }
            heavy_items.empty?
          else
            package_weight(package) <= max_allowed_weight
          end
        end

        def max_allowed_weight
          @max_allowed_weight ||= (Spree::CorreiosShipping::Config[:max_shipping_weight] || 30.0).to_f
        end

        def package_weight(package)
          default_weight = Spree::CorreiosShipping::Config[:default_item_weight].to_f

          package_weight = package.contents.inject(0.0) do |total_weight, content_item|
            item_weight = content_item.variant.weight.to_f
            item_weight = default_weight if item_weight <= 0
            total_weight += item_weight * content_item.quantity
          end

          package_weight
        end

        def cache_key(package)
          stock_location = package.stock_location.nil? ? "" : "#{package.stock_location.id}-"
          order = package.order
          ship_address = package.order.ship_address
          contents_hash = Digest::MD5.hexdigest(package.contents.map {|content_item| content_item.variant.id.to_s + "_" + content_item.quantity.to_s }.join("|"))
          @cache_key = "#{stock_location}-#{order.number}-#{ship_address.country.iso}-#{fetch_best_state_from_address(ship_address)}-#{ship_address.city}-#{ship_address.zipcode}-#{contents_hash}-#{I18n.locale}".gsub(" ","")
        end

        def fetch_best_state_from_address address
          address.state ? address.state.abbr : address.state_name
        end

        def build_location address
          location = Struct.new(:country, :state, :city, :zipcode)

          location.new(address.country.iso,
                       fetch_best_state_from_address(address),
                       address.city,
                       address.zipcode)
        end

        def retrieve_rates(origin, destination, package)
          #begin
            services = Spree::CorreiosShipping::Config[:services].split(',')
            services.map! { |s| s.strip.to_sym }
            webservice = ::Correios::Frete::Calculador.new :cep_origem => origin.zipcode,
              :cep_destino => destination.zipcode,
              :peso => package_weight(package),
              :comprimento => 30,
              :largura => 15,
              :altura => 2,
              :codigo_empresa => Spree::CorreiosShipping::Config[:id_correios],
              :senha => Spree::CorreiosShipping::Config[:password_correios]

            response = webservice.calculate(*services)

            unless response.nil?
              return {response.nome.downcase.to_sym => {price: response.valor, delivery_time: response.prazo_entrega}}  unless response.is_a?(Hash)
              response_hash = {}
              services.each do |service|
                response_hash[service] = {price: response[service].valor, delivery_time: response[service].prazo_entrega}
              end
            end

            response_hash
          #rescue => e
            #message = e.message
            #error = Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
            #Rails.cache.write @cache_key, error #write error to cache to prevent constant re-lookups
            #raise error
          #end
        end

        def retrieve_rates_from_cache package, origin, destination
          Rails.cache.fetch(cache_key(package)) do
            retrieve_rates(origin, destination, package)
          end
        end

        #def retrieve_timings(origin, destination, packages)
        #begin
        #if carrier.respond_to?(:find_time_in_transit)
        #response = carrier.find_time_in_transit(origin, destination, packages)
        #return response
        #end
        #rescue ActiveMerchant::Shipping::ResponseError => re
        #if re.response.is_a?(ActiveMerchant::Shipping::Response)
        #params = re.response.params
        #if params.has_key?("Response") && params["Response"].has_key?("Error") && params["Response"]["Error"].has_key?("ErrorDescription")
        #message = params["Response"]["Error"]["ErrorDescription"]
        #else
        #message = re.message
        #end
        #else
        #message = re.message
        #end

        #error = Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
        #Rails.cache.write @cache_key+"-timings", error #write error to cache to prevent constant re-lookups
        #raise error
        #end
        #end
      end
    end
  end
end
