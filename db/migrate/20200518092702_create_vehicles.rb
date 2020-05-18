class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.references :vehicle_type
      t.references :make

      t.timestamps
    end
  end
end
