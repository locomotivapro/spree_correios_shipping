require_dependency 'spree/calculator'

module Spree
  class Calculator
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

        def deliver_time(calculable, service)
          order = if calculable.is_a?(Shipment)
            calculable.order
          elsif calculable.is_a?(Order)
            calculable
          end
          deliver = order.correios_values
          deliver[service][:delivery_time]
        end

      end
    end
  end
end
