module Spree
  class Calculator < ActiveRecord::Base
    module Services
      class ESedexGrupo2 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex Grupo 2 - 81833"
        end
        
        def compute(order)
          super(order, :e_sedex_grupo_2)
        end
        
      end
    end
  end
end