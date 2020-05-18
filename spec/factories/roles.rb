FactoryBot.define do
  factory :role do
    name  { 'Customer' }
  end

  factory :technician_role, parent: :role do
    name  { 'Technician' }
  end

  factory :sales_rep_role, parent: :role do
    name  { 'SalesRep' }
  end
end
