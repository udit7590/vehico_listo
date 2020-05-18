FactoryBot.define do
  factory :price do
    amount_cents  { 100000 }
    amount_currency { 'USD' }
  end
end
