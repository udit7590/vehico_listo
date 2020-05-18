class VehicleInspection < ApplicationRecord
  belongs_to :watched_by, class_name: 'User', optional: true
  belongs_to :stock_item
  belongs_to :variant
end
