require_dependency 'spree/calculator'

module Spree
  class Calculator
    module Services
      class ESedexGrupo1 < Spree::Calculator::CorreiosBase::Base

        def self.description
          "e-Sedex Grupo 1 - 81868"
        end

        def available?(order)
          super(order, :e_sedex_grupo_1)
        end

        def compute(order)
          super(order, :e_sedex_grupo_1)
        end

        def deliver_time(order)
          super(order, :e_sedex_grupo_1)
        end

      end
    end
  end
end
