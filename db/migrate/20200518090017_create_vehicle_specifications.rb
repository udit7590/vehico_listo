class CreateVehicleSpecifications < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_specifications do |t|
      t.string :cylinders
      t.string :displacement
      t.string :transmission
      t.string :drive_train

      t.timestamps
    end
  end
end
