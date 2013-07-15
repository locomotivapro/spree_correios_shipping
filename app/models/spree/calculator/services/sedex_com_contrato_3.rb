require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class SedexComContrato3 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex com Contrato 3 - 40444"
        end
        
        def available?(order)
          super(order, :sedex_com_contrato_3)
        end
        
        def compute(order)
          super(order, :sedex_com_contrato_3)
        end
        
      end
    end
  end
end