module Spree
  module Calculator::Shipping
    module Correios
      class SedexEcommerce < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex E-commerce - 04162"
        end

        def self.service_code
          :sedex_ecommerce
        end

      end
    end
  end
end
