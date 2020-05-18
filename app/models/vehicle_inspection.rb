class VehicleInspection < ApplicationRecord
  MAX = (2**(0.size * 8 -2) -1)

  belongs_to :watched_by, class_name: 'User', optional: true
  belongs_to :stock_item
  belongs_to :variant
end
