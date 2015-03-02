require 'digest/md5'
require 'ostruct'
require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    module Correios
      class Base < ShippingCalculator

        def available?(package)
          is_package_shippable?(package)
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

          rates_result = retrieve_rates_from_cache(package, origin, destination)

          return nil if rates_result.kind_of?(Spree::ShippingError)
          return nil if rates_result.empty?
          rate = rates_result[self.class.service_code]

          return nil unless rate

          return rate
        end

        #def timing(line_items)
        #order = line_items.first.order
        ## TODO: Figure out where stock_location is supposed to come from.
        #origin= Location.new(:country => stock_location.country.iso,
        #:city => stock_location.city,
        #:state => (stock_location.state ? stock_location.state.abbr : stock_location.state_name),
        #:zip => stock_location.zipcode)
        #addr = order.ship_address
        #destination = Location.new(:country => addr.country.iso,
        #:state => (addr.state ? addr.state.abbr : addr.state_name),
        #:city => addr.city,
        #:zip => addr.zipcode)
        #timings_result = Rails.cache.fetch(cache_key(package)+"-timings") do
        #retrieve_timings(origin, destination, packages(order))
        #end
        #raise timings_result if timings_result.kind_of?(Spree::ShippingError)
        #return nil if timings_result.nil? || !timings_result.is_a?(Hash) || timings_result.empty?
        #return timings_result[self.description]
        #end

        private
        def is_package_shippable?(package)
          package_weight(package) <= 30.0
        end

        def package_weight(package=nil)
          raise StandardError if package.nil? && @package_weight.nil?
          default_weight = Spree::CorreiosShipping::Config[:default_item_weight].to_f

          @package_weight ||= package.contents.inject(0.0) do |total_weight, content_item|
            item_weight = content_item.variant.weight.to_f
            item_weight = default_weight if item_weight <= 0
            total_weight += item_weight * content_item.quantity
          end

          @package_weight
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
          begin
            services = Spree::CorreiosShipping::Config[:services].split(',')
            services.map! { |s| s.strip.to_sym }
            frete = Correios::Frete::Calculador.new :cep_origem => origin.zipcode,
                                                    :cep_destino => destination.zipcode,
                                                    :peso => package_weight,
                                                    :comprimento => 30,
                                                    :largura => 15,
                                                    :altura => 2,
                                                    :codigo_empresa => Spree::CorreiosShipping::Config[:id_correios],
                                                    :senha => Spree::CorreiosShipping::Config[:password_correios]

            response = frete.calcular(*services)

            unless response.nil?
              response_hash = {}
              services.each do |service|
                response_hash[service] = {price: response[service].valor, delivery_time: response[service].prazo_entrega}
              end
            end

            response_hash
          rescue => e
            message = e.message
            error = Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
            Rails.cache.write @cache_key, error #write error to cache to prevent constant re-lookups
            raise error
          end
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
