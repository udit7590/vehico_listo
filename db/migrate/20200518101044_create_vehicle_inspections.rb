class CreateVehicleInspections < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_inspections do |t|
      t.decimal :grade, precision: 4, scale: 2
      t.string :condition_report_url
      t.integer :mileage
      t.references :watched_by
      t.references :stock_item
      t.references :variant

      t.timestamps
    end
  end
end
