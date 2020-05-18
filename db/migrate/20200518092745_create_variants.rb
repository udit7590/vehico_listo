class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.references :vehicle
      t.references :vehicle_specification
      t.references :model_variant

      t.timestamps
    end
  end
end
