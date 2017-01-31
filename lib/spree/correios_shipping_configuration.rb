class Spree::CorreiosShippingConfiguration < Spree::Preferences::Configuration

  preference :origin_zip_code, :string, :default => ""
  preference :id_correios, :string, :default => ""
  preference :password_correios, :string, :default => ""
  preference :services, :string, :default => ""
  preference :default_item_weight, :float, default:  0.500
  preference :max_shipping_weight, :float, default: 30.0
  preference :split_shipments, :boolean, default: false

  preference :default_item_width, :float, default: 2
  preference :default_item_height, :float, default: 2
  preference :default_item_depth, :float, default: 0.2
  preference :default_width, :integer, default: 15
  preference :default_height, :integer, default: 20
  preference :default_depth, :integer, default: 5
end
