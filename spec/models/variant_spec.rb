require 'rails_helper'

describe Variant do
  let(:vehicle_types) do
    [
      create(:vehicle_type, name: 'suv'),
      create(:vehicle_type, name: 'van'),
      create(:vehicle_type, name: 'sedan'),
      create(:vehicle_type, name: 'hatchback')
    ]
  end
  let(:colour_option_type) { create(:option_type, name: 'exterior_colour') }
  let(:colour_option_values) do
    [
      create(:option_value, option_type: colour_option_type, value: 'black'),
      create(:option_value, option_type: colour_option_type, value: 'red'),
      create(:option_value, option_type: colour_option_type, value: 'green'),
      create(:option_value, option_type: colour_option_type, value: 'blue')
    ]
  end
  let(:vehicles) do
    [
      create(:vehicle, vehicle_type: vehicle_types[0]),
      create(:vehicle, vehicle_type: vehicle_types[1]),
      create(:vehicle, vehicle_type: vehicle_types[2])
    ]
  end

  let(:variants) do
    [
      create(:variant, vehicle: vehicles[0], build_option_values: colour_option_values[1]),
      create(:variant, vehicle: vehicles[1], build_option_values: colour_option_values[2]),
      create(:variant, vehicle: vehicles[2], build_option_values: colour_option_values[0]),
      create(:variant, vehicle: vehicles[0], build_option_values: colour_option_values[2]),
      create(:variant, vehicle: vehicles[1], build_option_values: colour_option_values[1]),
    ]
  end
  let(:stock_items) do
    [
      create(:stock_item, variant: variants[0],
              price: build(:price, variant: variants[0], amount_cents: 10000),
              vehicle_inspection: build(:vehicle_inspection, variant: variants[0], mileage: 5000)
            ),
      create(:stock_item, variant: variants[1],
              price: build(:price, variant: variants[1], amount_cents: 20000),
              vehicle_inspection: build(:vehicle_inspection, variant: variants[1], mileage: 6000)
            ),
      create(:stock_item, variant: variants[2],
              price: build(:price, variant: variants[2], amount_cents: 30000),
              vehicle_inspection: build(:vehicle_inspection, variant: variants[2], mileage: 7000)
            ),
      create(:stock_item, variant: variants[3],
              price: build(:price, variant: variants[3], amount_cents: 40000),
              vehicle_inspection: build(:vehicle_inspection, variant: variants[3], mileage: 8000)
            ),
      create(:stock_item, variant: variants[4],
              price: build(:price, variant: variants[4], amount_cents: 50000),
              vehicle_inspection: build(:vehicle_inspection, variant: variants[4], mileage: 9000)
            )
    ]
  end

  context 'filters' do
    before { stock_items }

    context 'size_id' do
      it 'filters variants by a particular vehicle size like suv' do
        expect(Variant.filter_by_size_id(vehicle_types[0].id).count).to eq(2)
        expect(Variant.filter_by_size_id(vehicle_types[2].id).count).to eq(1)
        expect(Variant.filter_by_size_id(vehicle_types[3].id).count).to eq(0)
      end
    end

    context 'colour_id' do
      it 'filters variants by a particular vehicle external colour like blank' do
        expect(Variant.filter_by_colour_id(colour_option_values[0].id).count).to eq(1)
        expect(Variant.filter_by_colour_id(colour_option_values[2].id).count).to eq(2)
        expect(Variant.filter_by_colour_id(colour_option_values[3].id).count).to eq(0)
      end
    end

    context 'mileage_min' do
      it 'filters variants by mileage min' do
        expect(Variant.filter_by_mileage_min(9001).count).to eq(0)
        expect(Variant.filter_by_mileage_min(8999).count).to eq(1)
      end
    end

    context 'mileage_max' do
      it 'filters variants by mileage max' do
        expect(Variant.filter_by_mileage_max(4999).count).to eq(0)
        expect(Variant.filter_by_mileage_max(5001).count).to eq(1)
      end
    end

    context 'price_min' do
      it 'filters variants by price min' do
        expect(Variant.filter_by_price_min(501).count).to eq(0)
        expect(Variant.filter_by_price_min(499).count).to eq(1)
      end
    end

    context 'price_max' do
      it 'filters variants by price max' do
        expect(Variant.filter_by_price_max(99).count).to eq(0)
        expect(Variant.filter_by_price_max(101).count).to eq(1)
      end
    end
  end
end
