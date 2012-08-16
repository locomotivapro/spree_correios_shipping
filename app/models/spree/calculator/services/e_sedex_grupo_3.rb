require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class ESedexGrupo3 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex Grupo 3 - 81850"
        end
        
        def compute(order)
          super(order, :e_sedex_grupo_3)
        end
        
      end
    end
  end
end