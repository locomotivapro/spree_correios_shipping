module Spree
  module Calculator::Shipping
    module Correios
      class PacComContrato < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Pac com contrato - 41068"
        end

        def self.service_code
          :pac_com_contrato
        end

      end
    end
  end
end
