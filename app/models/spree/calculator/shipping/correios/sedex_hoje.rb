module Spree
  module Calculator::Shipping
    module Correios
      class SedexHoje < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex hoje sem contrato - 40290"
        end

        def self.service_code
          :sedex_hoje
        end

      end
    end
  end
end
