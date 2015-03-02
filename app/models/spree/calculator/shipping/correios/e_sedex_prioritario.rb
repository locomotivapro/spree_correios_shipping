module Spree
  module Calculator::Shipping
    module Correios
      class ESedexPrioritario < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "e-Sedex Prioritario - 81027"
        end

        def self.service_code
          :e_sedex_prioritario
        end

      end
    end
  end
end
