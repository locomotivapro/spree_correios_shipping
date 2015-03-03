class Spree::CorreiosShippingConfiguration < Spree::Preferences::Configuration

  preference :origin_zip_code, :string, :default => ""
  preference :id_correios, :string, :default => ""
  preference :password_correios, :string, :default => ""
  preference :services, :string, :default => ""
  preference :default_item_weight, :float, default:  0.500
  preference :max_shipping_weight, :float, default: 30.0
  preference :split_shipments, :boolean, default: false
end
