class CreateStockLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_locations do |t|
      t.string :city
      t.string :province
      t.string :country

      t.timestamps
    end
  end
end
