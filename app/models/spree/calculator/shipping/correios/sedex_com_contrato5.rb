module Spree
  module Calculator::Shipping
    module Correios
      class SedexComContrato5 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex com Contrato 5 - 40606"
        end

        def self.service_code
          :sedex_com_contrato_5
        end

      end
    end
  end
end
