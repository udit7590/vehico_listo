FactoryBot.define do
  factory :make do
    name  { FFaker::Vehicle.make }
  end
end
