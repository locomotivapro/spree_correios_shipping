module Spree
  module Calculator::Shipping
    module Correios
      class SedexComContrato2 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex com Contrato 2 - 40436"
        end

        def self.service_code
          :sedex_com_contrato_2
        end

      end
    end
  end
end
