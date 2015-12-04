class AddDaysAndInfoToSpreeShippingRates < ActiveRecord::Migration
  def change
    add_column :spree_shipping_rates, :days, :string
    add_column :spree_shipping_rates, :info, :string
  end
end
