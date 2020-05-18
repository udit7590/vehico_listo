FactoryBot.define do
  factory :vehicle_inspection do
    grade  { 4.0 }
    cylinders { FFaker::Vehicle.engine_cylinders }
    displacement { FFaker::Vehicle.engine_displacement.to_s }
    condition_report_url { "http://crd.aiminspections.com/crd/PDFReport.aspx?report=DZ0TBxLnToEJTFrRVMuzeeqaTZwAo7xqIBtv33Gq5LXnpiWSENo%2fYcIMISPp9nZ4kKkCPbfZUg25e8BS2xuo3fxhv2TuUecg5OI6wYM%2fYXoUL4gno0ODuA%3d%3d" }
    stock_item
    association :watched_by, factory: :technician
  end
end
