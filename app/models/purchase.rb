class Purchase < ApplicationRecord
  monetize :amount_cents

  belongs_to :variant
  belongs_to :stock_item
  belongs_to :customer, class_name: 'User'
  belongs_to :sales_rep, class_name: 'User'

  validates_presence_of :amount_cents
  validates_presence_of :amount_currency
end
