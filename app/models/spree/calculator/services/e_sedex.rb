require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class ESedex < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex - 81019"
        end

        def available?(order)
          super(order, :e_sedex)
        end

        def compute(order)
          super(order, :e_sedex)
        end

        def deliver_time(order)
          super(order, :e_sedex)
        end

      end
    end
  end
end
