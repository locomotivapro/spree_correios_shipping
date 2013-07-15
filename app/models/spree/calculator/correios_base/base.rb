require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CorreiosBase
      class Base < Calculator

        def available?(order, service)
          weight = order.line_items.inject(0) do |weight, line_item|
            weight + (line_item.variant.weight ? (line_item.quantity * line_item.variant.weight ) : 0)
          end
          price = compute(order)
          (weight > 30 || price <= 0) ? false : true
        end

        def compute(order, service)
          count = 0
          frete = Correios::Frete::Calculador.new :cep_origem => Spree::CorreiosShipping::Config[:origin_zip_code],
                                                            :cep_destino => ship_zipcode_from(order),
                                                            :peso => weight_from(order),
                                                            :comprimento => 30,
                                                            :largura => 15,
                                                            :altura => 2,
                                                            :codigo_empresa => Spree::CorreiosShipping::Config[:id_correios],
                                                            :senha => Spree::CorreiosShipping::Config[:password_correios]
          begin
            servico = frete.calcular service
            servico.valor
          rescue Errno::ECONNRESET => e
            count += 1
            retry unless count > 3
            0
          end
        end

      private
        def weight_from(order)
          order.line_items.reduce(0) { |sum, line_item| sum + ((weight_for(line_item) * line_item.quantity) || 0) }
        end

        def weight_for(line_item)
          line_item.variant.weight.present? ? line_item.variant.weight : 1
        end

        def ship_zipcode_from(line_items)
          if line_items.is_a?(Array)
            order = line_items.first.order
          elsif line_items.is_a?(Shipment)
            order = line_items.order
          else
            order = line_items
          end

          order.ship_address.zipcode
        end


      end
    end
  end
end
