require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class SedexACobrarComContrato < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex a cobrar com contrato - 40126"
        end

        def available?(order)
          super(order, :sedex_a_cobrar_com_contrato)
        end

        def compute(order)
          super(order, :sedex_a_cobrar_com_contrato)
        end

      end
    end
  end
end
