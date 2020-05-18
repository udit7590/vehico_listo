class Variant < ApplicationRecord
  include Filtering

  belongs_to :vehicle
  belongs_to :vehicle_specification, optional: true
  belongs_to :model_variant, optional: true

  has_many :prices
  has_many :vehicle_inspections
  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  has_many :stock_items

  filter_by :price_min, ->(min) do
    min = min.to_i * 100 # cents
    joins(:prices).where('prices.amount_cents > ?', min)
  end
  filter_by :price_max, ->(max) do
    max = max.to_i * 100 # cents
    joins(:prices).where('prices.amount_cents < ?', max)
  end
  filter_by :mileage_min, ->(min) do
    joins(:vehicle_inspections).where('vehicle_inspections.mileage > ?', min)
  end
  filter_by :mileage_max, ->(max) do
    joins(:vehicle_inspections).where('vehicle_inspections.mileage < ?', max)
  end
  filter_by :size_id, -> (size_id) { joins(vehicle: :vehicle_type).where('vehicles.vehicle_type_id = ?', size_id) }
  filter_by :colour_id, -> (colour_id) do
    option_type = OptionType.find_by(name: :exterior_colour)
    option_values = option_type.option_values.where(id: colour_id)
    joins(:option_value_variants).where(option_value_variants: { option_value_id: colour_id })
  end
end
