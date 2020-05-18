class CreateModelVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :model_variants do |t|
      t.string :series
      t.integer :year

      t.timestamps
    end
  end
end
