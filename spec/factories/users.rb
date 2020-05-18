FactoryBot.define do
  factory :user do
    first_name  { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    role
  end

  factory :technician, parent: :user do
    association :role, factory :technician_role
  end

  factory :sales_rep, parent: :user do
    association :role, factory :sales_rep_role
  end
end
