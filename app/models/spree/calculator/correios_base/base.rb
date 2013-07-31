require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CorreiosBase
      class Base < Calculator

        def available?(order, service)
          prices = order.correios_values
          (prices[service] && prices[service][:price] > 0) ? true : false
        end

        def compute(calculable, service)
          order = if calculable.is_a?(Shipment)
            calculable.order
          elsif calculable.is_a?(Order)
            calculable
          end
          prices = order.correios_values
          prices[service][:price]
        end

      end
    end
  end
end
