require 'correios-frete'

module Spree
  class Calculator < ActiveRecord::Base
    module Sedex
      class Base < Calculator
        
        preference :origin_zip_code, :string, :default => "03146020"
        preference :service_code, :string, :default => ""
        preference :id_correios, :string, :default => ""
        preference :password_correios, :string, :default => ""


        def self.description
          "sedex"
        end

        def available?(order)
          weight = order.line_items.inject(0) do |weight, line_item|
            weight + (line_item.variant.weight ? (line_item.quantity * line_item.variant.weight ) : 0)
          end
          weight > 30 ? false : true
        end

        def compute(order)
          frete = Correios::Frete::Calculador.new :cep_origem => self.preferred_origin_zip_code,
                                                  :cep_destino => ship_zipcode_from(order),
                                                  :peso => weight_from(order),
                                                  :comprimento => 30,
                                                  :largura => 15,
                                                  :altura => 2,
                                                  :codigo_empresa => self.preferred_id_correios,
                                                  :senha => self.preferred_password_correios

           servico = frete.calcular :sedex
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