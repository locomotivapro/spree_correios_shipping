require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class SedexComContrato2 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex com Contrato 2 - 40436"
        end
        
        def available?(order)
          super(order, :sedex_com_contrato_2)
        end
        
        def compute(order)
          super(order, :sedex_com_contrato_2)
        end
        
      end
    end
  end
end