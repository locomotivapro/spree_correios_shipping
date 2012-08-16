require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class SedexACobrar < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex a cobrar sem contrato - 40045"
        end
        
        def compute(order)
          super(order, :sedex_a_cobrar)
        end
        
      end
    end
  end
end