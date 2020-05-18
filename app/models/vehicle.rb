class Vehicle < ApplicationRecord
  belongs_to :vehicle_type, optional: true
  belongs_to :make

  has_many :variants
end
