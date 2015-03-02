module Spree
  module Calculator::Shipping
    module Correios
      class ESedexGrupo3 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "e-Sedex Grupo 3 - 81850"
        end

        def self.service_code
          :e_sedex_grupo_3
        end

      end
    end
  end
end
