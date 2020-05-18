class StockItem < ApplicationRecord
  belongs_to :variant, autosave: true
  belongs_to :stock_location, autosave: true
  belongs_to :dealer, autosave: true, optional: true

  has_one :vehicle_inspection, autosave: true
  has_one :price, autosave: true
  has_one :purchase, autosave: true
end
