require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class ESedex < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex - 81019"
        end
        
        def compute(order)
          super(order, :e_sedex)
        end
        
      end
    end
  end
end