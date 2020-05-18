FactoryBot.define do
  factory :vehicle_specification do
    cylinders { FFaker::Vehicle.engine_cylinders }
    displacement { FFaker::Vehicle.engine_displacement.to_s }
    transmission { FFaker::Vehicle.transmission_abbr }
    drive_train { FFaker::Vehicle.drivetrain }
  end
end
