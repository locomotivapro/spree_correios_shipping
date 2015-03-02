module Spree
  module Calculator::Shipping
    module Correios
      class Overweight < Spree::Calculator::Shipping::Correios::Base

        def self.description
          "Acima de 30kg"
        end

        def available?(package)
          package_weight > 30 ? true : false
        end

        def compute_package(package)
          0.00
        end

        def deliver_time(package)
          nil
        end

      end
    end
  end
end
