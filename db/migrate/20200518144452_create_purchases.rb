class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :variant
      t.references :stock_item
      t.references :customer
      t.references :sales_rep

      t.integer :amount_cents
      t.string :amount_currency

      t.timestamps
    end
  end
end
