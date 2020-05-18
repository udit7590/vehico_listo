class CreateOptionValues < ActiveRecord::Migration[6.0]
  def change
    create_table :option_values do |t|
      t.string :value
      t.references :option_type

      t.timestamps
    end
  end
end
