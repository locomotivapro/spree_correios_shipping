module Spree
  module Calculator::Shipping
    module Correios
      class SedexComContrato3 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex com Contrato 3 - 40444"
        end

        def self.service_code
          :sedex_com_contrato_3
        end

      end
    end
  end
end
