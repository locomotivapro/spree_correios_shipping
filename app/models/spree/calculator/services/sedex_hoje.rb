require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class SedexHoje < Spree::Calculator::CorreiosBase::Base

        def self.description
          "Sedex hoje sem contrato - 40290"
        end
        
        def compute(order)
          super(order, :sedex_hoje)
        end
        
      end
    end
  end
end