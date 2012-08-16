require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class Sedex < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex sem contrato - 40010"
        end
        
        def compute(order)
          super(order, :sedex)
        end
        
      end
    end
  end
end