module Spree
  module Calculator::Shipping
    module Correios
      class ESedex < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "e-Sedex - 81019"
        end

        def self.service_code
          :e_sedex
        end
      end
    end
  end
end
