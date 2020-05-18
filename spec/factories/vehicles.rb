FactoryBot.define do
  factory :vehicle do
    model { FFaker::Vehicle.model }
    make
    vehicle_type
  end
end
