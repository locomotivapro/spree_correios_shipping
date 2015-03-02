module Spree
  module Calculator::Shipping
    module Correios
      class SedexComContrato1 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex com Contrato 1 - 40096"
        end

        def self.service_code
          :sedex_com_contrato_1
        end

      end
    end
  end
end
