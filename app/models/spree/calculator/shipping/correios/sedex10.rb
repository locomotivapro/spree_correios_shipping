module Spree
  module Calculator::Shipping
    module Correios
      class Sedex10 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex 10 sem contrato - 40215"
        end

        def self.service_code
          :sedex_10
        end

      end
    end
  end
end
