Spree::ShippingRate.class_eval do
  def timing_info
    if days || info
      text = [Spree.t(:pre_delivery_days_info)]
      text << "#{days} #{Spree.t(:delivery_days)}" if days
      text << "(#{info})" unless info.blank?
      text.join(' ')
    end
  end
end
