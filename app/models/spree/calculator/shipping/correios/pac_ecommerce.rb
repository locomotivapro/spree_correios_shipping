module Spree
  module Calculator::Shipping
    module Correios
      class PacEcommerce < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Pac E-commerce - 04669"
        end

        def self.service_code
          :pac_ecommerce
        end

      end
    end
  end
end
