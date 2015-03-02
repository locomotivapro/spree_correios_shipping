module Spree
  module Calculator::Shipping
    module Correios
      class Sedex < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex sem contrato - 40010"
        end

        def self.service_code
          :sedex
        end

      end
    end
  end
end
