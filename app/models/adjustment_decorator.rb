require_dependency 'spree/calculator'

Spree::Adjustment.class_eval do
  def update!(src = nil)
    src ||= source
    return if locked?
    if originator.present? && !originator.calculator.class.ancestors.include?(Spree::Calculator::CorreiosBase::Base)
      originator.update_adjustment(self, src)
    end
    set_eligibility
  end
end

=begin

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
    logger.info "RATE HASH ==>>>>>> #{@rate_hash}"
    @rate_hash
  end
  
  
end

Spree::ShippingMethod.class_eval do
  
  def self.all_available(order, display_on = nil)
    correios_methods = []
    other_methods = []
    
    all.each do |method|
      if method.calculator.class.ancestors.include?(Spree::Calculator::CorreiosBase::Base)
        correios_methods << method
      else
        other_methods << method
      end
    end
    
    coletar_nomes_dos_calculadores
    
    calcular um arra
    
    
    
    
    all.select { |method| method.available_to_order?(order, display_on) }
  end
  
end
=end