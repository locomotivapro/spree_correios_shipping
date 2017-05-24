module Spree
  module Calculator::Shipping
    module Correios
      class Overweight < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Acima de 30kg ou fora das medidas máximas"
        end

        def available?(package)
          !is_package_shippable?(package) || !box_for(package)
        end

        def compute_package(package)
          0.00
        end

        def timing_info(package)
          nil
        end

      end
    end
  end
end
