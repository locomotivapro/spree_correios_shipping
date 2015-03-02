module Spree
  module Calculator::Shipping
    module Correios
      class ESedexExpress < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "e-Sedex Express - 81035"
        end

        def self.service_code
          :e_sedex_express
        end

      end
    end
  end
end
