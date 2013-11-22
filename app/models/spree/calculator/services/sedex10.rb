require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class Sedex10 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex 10 sem contrato - 40215"
        end

        def available?(order)
          super(order, :sedex_10)
        end

        def compute(order)
          super(order, :sedex_10)
        end

      end
    end
  end
end
