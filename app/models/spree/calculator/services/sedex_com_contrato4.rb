require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class SedexComContrato4 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex com Contrato 4 - 40568"
        end

        def available?(order)
          super(order, :sedex_com_contrato_4)
        end

        def compute(order)
          super(order, :sedex_com_contrato_4)
        end

        def deliver_time(order)
          super(order, :sedex_com_contrato_4)
        end


      end
    end
  end
end
