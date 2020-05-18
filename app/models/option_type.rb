class OptionType < ApplicationRecord
  has_many :option_values

  validates_presence_of :name
end
