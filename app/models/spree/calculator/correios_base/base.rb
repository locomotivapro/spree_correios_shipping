require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CorreiosBase
      class Base < Calculator
        
        def available?(order)
          weight = order.line_items.inject(0) do |weight, line_item|
            weight + (line_item.variant.weight ? (line_item.quantity * line_item.variant.weight ) : 0)
          end
          weight > 30 ? false : true
        end

        def compute(order, service)
          frete = Correios::Frete::Calculador.new :cep_origem => Spree::CorreiosShipping::Config[:origin_zip_code],
                                                  :cep_destino => ship_zipcode_from(order),
                                                  :peso => weight_from(order),
                                                  :comprimento => 30,
                                                  :largura => 15,
                                                  :altura => 2,
                                                  :codigo_empresa => Spree::CorreiosShipping::Config[:id_correios],
                                                  :senha => Spree::CorreiosShipping::Config[:password_correios]

           servico = frete.calcular service
           servico.valor
        end

      private
        def weight_from(order)
          order.line_items.reduce(0) { |sum, line_item| sum + ((line_item.variant.weight * line_item.quantity) || 0) }
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