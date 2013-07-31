require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class Overweight < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Acima de 30kg"
        end
        
        def available?(order)
          order.weight > 30 ? true : false
        end
        
        def compute(order)
          0.00
        end
        
      end
    end
  end
end
