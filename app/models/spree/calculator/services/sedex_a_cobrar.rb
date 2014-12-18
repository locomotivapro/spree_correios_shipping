require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class SedexACobrar < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex a cobrar sem contrato - 40045"
        end

        def available?(order)
          super(order, :sedex_a_cobrar)
        end

        def compute(order)
          super(order, :sedex_a_cobrar)
        end

        def deliver_time(order)
          super(order, :sedex_a_cobrar)
        end

      end
    end
  end
end
