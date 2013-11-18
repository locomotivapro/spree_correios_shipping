require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class ESedexGrupo3 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex Grupo 3 - 81850"
        end

        def available?(order)
          super(order, :e_sedex_grupo_3)
        end

        def compute(order)
          super(order, :e_sedex_grupo_3)
        end

      end
    end
  end
end
