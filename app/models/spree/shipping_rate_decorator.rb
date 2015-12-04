Spree::ShippingRate.class_eval do

  def timing_info
    if days
      text = [Spree.t(:pre_delivery_days_info), days, Spree.t(:delivery_days)]
      text << "(#{info})" if info
      text.join(' ')
    end
  end

end

