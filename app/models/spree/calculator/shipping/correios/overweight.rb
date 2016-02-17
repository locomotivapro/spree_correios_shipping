module Spree
  module Calculator::Shipping
    module Correios
      class Overweight < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Acima de 30kg"
        end

        def available?(package)
          max_weight = (Spree::CorreiosShipping::Config[:max_shipping_weight] || 30.0).to_f
          package_weight(package) >= max_weight ? true : false
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
