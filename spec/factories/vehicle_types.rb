FactoryBot.define do
  factory :vehicle_type do
    name { ['suv', 'hatchback', 'sedan', 'van', 'truck', 'pickupvan'].sample }
  end
end
