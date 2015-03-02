module Spree
  module Calculator::Shipping
    module Correios
      class SedexACobrar < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex a cobrar sem contrato - 40045"
        end

        def self.service_code
          :sedex_a_cobrar
        end

      end
    end
  end
end
