require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class SedexComContrato5 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex com Contrato 5 - 40606"
        end

        def available?(order)
          super(order, :sedex_com_contrato_5)
        end

        def compute(order)
          super(order, :sedex_com_contrato_5)
        end

        def deliver_time(order)
          super(order, :sedex_com_contrato_5)
        end


      end
    end
  end
end
