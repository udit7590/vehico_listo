class OptionValue < ApplicationRecord
  belongs_to :option_type

  validates_presence_of :value
end
