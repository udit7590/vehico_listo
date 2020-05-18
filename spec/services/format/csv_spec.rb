require 'rails_helper'

RSpec.describe ImporterService::Format::Csv do
  let(:file_name) { 'vehicles_list_1.csv' }
  let(:file) { Rails.root.join('spec', 'fixtures', file_name) }
  let(:import_service) { ImporterService::Format::Csv.new(file: file) }

  describe '#import' do
    context 'when csv file is empty' do
      let(:file_name) { 'vehicles_list_empty.csv' }

      it 'yields nothing' do
        count = 0
        import_service.import do |vehicle|
          count += 1
        end
        expect(count).to eq(0)
      end
    end

    context 'when csv file is not empty' do
      let(:output) do
        { vin:"5XXGT4L3XKG275766",
          grade: 3.6,
          stock_number: nil,
          make: "Kia",
          model: "Optima",
          series: "Lx",
          year: 2019,
          price_cents: 1340000,
          body: "Sedan",
          cylinders: "4",
          displacement: "2.4l",
          exterior_colour: "Silver",
          interior_colour: "Black",
          mileage: 43929,
          transmission: "6-speed A/t",
          upholstery: "Cloth",
          end_date: "Fri, 28 Feb 2020 19:30:00 +0000",
          stock_location_city: "Phoenix",
          stock_location_province: "AZ",
          stock_location_country: "USA",
          buy_date: nil,
          customer: nil,
          inspected_by: nil,
          dealer_name: nil,
          drive_train: "FWD",
          condition_report: "http://crd.aiminspections.com/crd/PDFReport.aspx?report=DZ0TBxLnToEzUwzoP6cBpu79nIM2sL9j40BfTR1zPSv1gocD6RanLVfXQYH7ahXjRm%2fO507sIcJOiEreoPlAX9%2bKnScL2NLuMx%2b0sW1Jks2qXqcbNLLwug%3d%3d",
          sales_rep: nil
        }
      end

      it 'yields' do
        count = 0
        vehicle_out = nil
        import_service.import do |vehicle|
          count += 1
          vehicle_out = vehicle
        end
        expect(count).to eq(1)
        expect(vehicle_out).to eq(output)
      end
    end
  end

end
