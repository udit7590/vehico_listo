class Price < ApplicationRecord
  MAX = (2**(0.size * 8 -2) -1)

  monetize :amount_cents

  DEFAULT_CURRENCY = 'USD'

  belongs_to :variant
  belongs_to :stock_item

  validates_presence_of :amount_cents
  validates_presence_of :amount_currency

  def display_amount
    amount.format
  end
end
