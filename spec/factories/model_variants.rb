FactoryBot.define do
  factory :model_variant do
    series { FFaker::Vehicle.trim }
    year { FFaker::Vehicle.year }
  end
end
