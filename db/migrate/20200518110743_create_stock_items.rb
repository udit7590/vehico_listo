class CreateStockItems < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_items do |t|
      t.string :vin
      t.references :variant
      t.references :stock_location
      t.references :dealer

      t.timestamps
    end
  end
end
