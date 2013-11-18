require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class SedexHoje < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex hoje sem contrato - 40290"
        end

        def available?(order)
          super(order, :sedex_hoje)
        end

        def compute(order)
          super(order, :sedex_hoje)
        end

      end
    end
  end
end
