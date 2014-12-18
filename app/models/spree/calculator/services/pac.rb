require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class Pac < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Pac sem contrato - 41106"
        end

        def available?(order)
          super(order, :pac)
        end

        def compute(order)
          super(order, :pac)
        end

        def deliver_time(order)
          super(order, :pac)
        end

      end
    end
  end
end
