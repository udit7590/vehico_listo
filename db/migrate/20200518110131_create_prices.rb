class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.references :stock_item
      t.references :variant # For caching mainly
      t.string :amount_currency
      t.integer :amount_cents

      t.timestamps
    end
  end
end
