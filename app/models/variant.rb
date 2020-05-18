class Variant < ApplicationRecord
  belongs_to :vehicle
  belongs_to :vehicle_specification, optional: true
  belongs_to :model_variant, optional: true

  has_many :prices
  has_many :vehicle_inspections
  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  has_many :stock_items
end
