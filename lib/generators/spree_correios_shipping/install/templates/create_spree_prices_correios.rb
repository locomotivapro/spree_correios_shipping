class CreateSpreePricesCorreios < ActiveRecord::Migration
  
  def change
    create_table :spree_prices_correios do |t|
      t.integer :order_id
      t.string :zipcode
      t.decimal :weight, :precision => 8, :scale => 2
      t.text :services
      t.timestamps
    end

    add_index :spree_prices_correios, :order_id, :name => 'index_prices_correios_on_order_id'
  end
end

