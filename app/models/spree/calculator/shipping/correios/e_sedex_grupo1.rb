module Spree
  module Calculator::Shipping
    module Correios
      class ESedexGrupo1 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "e-Sedex Grupo 1 - 81868"
        end

        def self.service_code
          :e_sedex_grupo_1
        end

      end
    end
  end
end
