require_dependency 'spree/calculator'

Spree::Adjustment.class_eval do
  
# private

  # def update_adjustable
  #   adjustable.update! if (adjustable.is_a? Order)
  #   logger.info 'CHAMANDO ADJUSTMENT UPDATE'
  # end
# private  
  def update!(src = nil)
    src ||= source
    return if locked?
    if originator.present? && !originator.calculator.class.ancestors.include?(Spree::Calculator::CorreiosBase::Base)
      originator.update_adjustment(self, src)
    end
    set_eligibility
  end
  
end

Spree::Order.class_eval do
  
  def update_adjustments
    self.adjustments.reload.each { |adjustment| adjustment.update!(self)  }
    logger.info 'CHAMANDO ORDER UPDATE'
  end
  #unless adjustment.originator.calculator.class.ancestors.include?(Spree::Calculator::CorreiosBase::Base)
  
  def rate_hash
    @rate_hash ||= available_shipping_methods(:front_end).collect do |ship_method|
      cost = ship_method.calculator.compute(self)
      next unless (cost && cost > 0)
      Spree::ShippingRate.new( :id => ship_method.id,
                        :shipping_method => ship_method,
                        :name => ship_method.name,
                        :cost => cost)
    end.compact.sort_by { |r| r.cost }
  end
  
  
end

Spree::ShippingMethod.class_eval do
  
  def self.all_available(order, display_on = nil)
    all.select { |method| method.available_to_order?(order, display_on) }
  end
  
end