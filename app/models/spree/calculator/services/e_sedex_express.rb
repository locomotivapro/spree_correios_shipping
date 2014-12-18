require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class ESedexExpress < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex Express - 81035"
        end

        def available?(order)
          super(order, :e_sedex_express)
        end

        def compute(order)
          super(order, :e_sedex_express)
        end

        def deliver_time(order)
          super(order, :e_sedex_express)
        end

      end
    end
  end
end
