module Spree
  module Calculator::Shipping
    module Correios
      class Pac < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Pac sem contrato - 41106"
        end

        def self.service_code
          :pac
        end

      end
    end
  end
end
