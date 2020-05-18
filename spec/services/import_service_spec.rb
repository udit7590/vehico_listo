require 'rails_helper'

RSpec.describe ImporterService do
  let(:file_name) { 'vehicles_list_1.csv' }
  let(:format) { 'csv' }
  let(:file) { Rails.root.join('spec', 'fixtures', file_name) }
  let(:import_service) { ImporterService.new(file: file, format: format) }

  describe '#format_klass' do
    it 'returns CSV class' do
      expect(import_service.format_klass).to eq(ImporterService::Format::Csv)
    end
  end

  describe '#import' do
    it 'imports the vehicles' do
      import_service.import
      expect(StockItem.count).to eq(1)
    end

    it 'does not duplicate the records for same data' do
      import_service.import
      expect(StockItem.count).to eq(1)
      import_service.import
      expect(StockItem.count).to eq(1)
    end

    context 'when csv file has more than 1 record' do
      let(:file_name) { 'vehicles_list_5.csv' }

      it 'loads all the records' do
        import_service.import
        expect(StockItem.count).to eq(5)
      end
    end
  end

end
