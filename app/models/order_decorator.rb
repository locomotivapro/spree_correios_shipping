Spree::Order.class_eval do
  has_one :prices_correio

  def correios_values
    if prices_correio
      if prices_correio.weight != weight || prices_correio.zipcode != ship_address.zipcode
        prices_correio.update_attributes(zipcode: ship_address.zipcode, weight: weight)
      end
    else
      create_prices_correio(zipcode: ship_address.zipcode, weight: weight)
    end
    prices_correio.services
  end

  def weight
    line_items.reduce(0) { |sum, line_item| sum + ((line_item.weight * line_item.quantity) || 0) }
  end
end
