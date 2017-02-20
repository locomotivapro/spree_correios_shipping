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
            total_weight += item_weight
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

        def map_from_shipping_methods
          available_shipping_methods = Spree::ShippingMethod.all
          correios_shipping_methods = available_shipping_methods.select { |sm| sm.calculator.type.constantize.superclass == Spree::Calculator::Shipping::Correios::Base }
          correios_shipping_methods.map! { |sm| sm.calculator.type.constantize.service_code }
        end

        def retrieve_rates(origin, destination, package)
          shipment_box = choose_best_box_for(package)

          #begin
          services = Spree::CorreiosShipping::Config[:services].split(',')
          services = map_from_shipping_methods if services.empty?
          services.map! { |s| s.is_a?(Symbol) ? s : s.strip.to_sym }
          webservice = ::Correios::Frete::Calculador.new :cep_origem => origin.zipcode,
            :cep_destino => destination.zipcode,
            :peso => package_weight(package),
            :comprimento => shipment_box[:width],
            :largura => shipment_box[:length],
            :altura => shipment_box[:height],
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

        def width_for(variant)
          if variant.width.nil?
            Spree::CorreiosShipping::Config[:default_item_width]
          else
            (variant.width * 100).to_i
          end
        end

        def height_for(variant)
          if variant.width.nil?
            Spree::CorreiosShipping::Config[:default_item_height]
          else
            (variant.height * 100).to_i
          end
        end

        def depth_for(variant)
          if variant.width.nil?
            Spree::CorreiosShipping::Config[:default_item_depth]
          else
            (variant.depth * 100).to_i
          end
        end

        def choose_best_box_for(package)
          available_boxes = Spree::ProductPackage.smallest_to_biggest
          selected_package = nil

          available_boxes.each do |box|
            items = package.contents.inject([]) do |item_array, item|
              variant = item.variant
              item_array << { dimensions: [width_for(variant), height_for(variant), depth_for(variant)] }
            end

            current_package = pack(box, items)

            if !current_package.nil? && current_package.length == 1
              selected_package = box
              break
            end
          end

          if selected_package.nil?
            {
              width: Spree::CorreiosShipping::Config[:default_width],
              height: Spree::CorreiosShipping::Config[:default_height],
              length: Spree::CorreiosShipping::Config[:default_length]
            }
          else
            {
              width: selected_package.width,
              height: selected_package.height,
              length: selected_package.length
            }
          end
        end

        def pack(box, items)
          ::BoxPacker.pack(
            container: { dimensions: [box.width, box.height, box.length] },
            items: items
          )
        rescue
          nil
        end

        def retrieve_rates_from_cache package, origin, destination
          Rails.cache.fetch(cache_key(package)) do
            retrieve_rates(origin, destination, package)
          end
        end

      end
    end
  end
end
