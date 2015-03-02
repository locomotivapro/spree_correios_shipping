module Spree
  module Calculator::Shipping
    module Services
      class SedexACobrarComContrato < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Sedex a cobrar com contrato - 40126"
        end

        def self.service_code
         :sedex_a_cobrar_com_contrato
        end

      end
    end
  end
end
