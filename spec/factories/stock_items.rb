FactoryBot.define do
  factory :stock_item do
    vin  { FFaker::Vehicle.vin }

    variant
    stock_location
    dealer
  end
end
