module Spree
  Stock::Estimator.class_eval do

    def calculate_shipping_rates(package, ui_filter)
      shipping_methods(package, ui_filter).map do |shipping_method|
        calculator = shipping_method.calculator
        cost = calculator.compute(package)

        timing_info = if calculator.respond_to? :timing_info
                        calculator.timing_info(package)
                      else
                        {}
                      end

        shipping_method.shipping_rates.new(
          cost: gross_amount(cost, taxation_options_for(shipping_method)),
          tax_rate: first_tax_rate_for(shipping_method.tax_category),
          days: timing_info[:days],
          info: timing_info[:info]
        ) if cost

      end.compact
    end

  end
end
