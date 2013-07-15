require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class SedexComContrato1 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex com Contrato 1 - 40096"
        end
        
        def available?(order)
          super(order, :sedex_com_contrato_1)
        end
        
        def compute(order)
          super(order, :sedex_com_contrato_1)
        end
        
      end
    end
  end
end