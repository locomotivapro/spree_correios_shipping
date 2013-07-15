require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class ESedexPrioritario < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex Prioritario - 81027"
        end
        
        def available?(order)
          super(order, :e_sedex_prioritario)
        end
        
        def compute(order)
          super(order, :e_sedex_prioritario)
        end
        
      end
    end
  end
end