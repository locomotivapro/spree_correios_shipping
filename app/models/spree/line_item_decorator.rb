Spree::LineItem.class_eval do
  def weight
    (variant.weight.present? && variant.weight > 0) ? variant.weight : 1
  end
end
