class StockLocation < ApplicationRecord
  DEFAULT_LOCATION = 'USA'

  has_many :stock_items

  validates_presence_of :city, :province
end
