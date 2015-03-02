module Spree
  module Calculator::Shipping
    module Correios
      class SedexComContrato4 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex com Contrato 4 - 40568"
        end

        def self.service_code
          :sedex_com_contrato_4
        end

      end
    end
  end
end
