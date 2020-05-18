class CreateOptionValueVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :option_value_variants do |t|
      t.references :variant
      t.references :option_value

      t.timestamps
    end
  end
end
