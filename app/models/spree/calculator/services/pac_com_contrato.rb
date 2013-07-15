require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class PacComContrato < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Pac com contrato - 41068"
        end
        
        def available?(order)
          super(order, :pac_com_contrato)
        end
        
        def compute(order)
          super(order, :pac_com_contrato)
        end
        
      end
    end
  end
end