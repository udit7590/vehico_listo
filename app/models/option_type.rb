class OptionType < ApplicationRecord
  DEFAULT_TYPES = [:upholstery, :exterior_colour, :interior_colour]

  has_many :option_values

  validates_presence_of :name
end
