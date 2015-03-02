module Spree
  module Calculator::Shipping
    module Correios
      class ESedexGrupo2 < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "e-Sedex Grupo 2 - 81833"
        end

        def self.service_code
          :e_sedex_grupo_2
        end

      end
    end
  end
end
