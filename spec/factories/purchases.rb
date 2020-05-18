FactoryBot.define do
  factory :purchase do
    amount_cents  { 100000 }
    amount_currency { 'USD' }
    variant
    association :stock_item, factory: :stock_item, variant: variant
  end
end
