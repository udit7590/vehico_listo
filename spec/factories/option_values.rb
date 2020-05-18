FactoryBot.define do
  factory :option_value do
    value  { FFaker::Vehicle.base_colour }
  end
end
