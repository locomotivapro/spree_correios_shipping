class Spree::Admin::CorreiosShippingSettingsController < Spree::Admin::BaseController
  def edit
    @preferences = [:id_correios, :password_correios, :services, :default_item_weight, :max_shipping_weight, :split_shipments, :default_item_width, :default_item_height, :default_item_depth, :default_width, :default_height, :default_depth]
    @config = Spree::CorreiosShippingConfiguration.new
  end

  def update
    config = Spree::CorreiosShippingConfiguration.new

    params.each do |name, value|
      next unless config.has_preference? name
      config[name] = value
    end

    redirect_to edit_admin_correios_shipping_settings_path
  end

end
