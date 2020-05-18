shared_examples 'filtering' do
  describe 'filtering' do
    let!(:record_1) { create(factory_name) }
    let!(:record_2) { create(factory_name, archived_at: 3.days.ago) }
    let!(:record_3) { create(factory_name, archived_at: 5.days.ago) }
    let!(:record_4) { create(factory_name) }

    let(:factory_name) { described_class.name.underscore }

    it do
      expect do
        record_1.archive
      end.to_not change { described_class.count }

      expect(record_1).to be_archived
      expect(record_1.archived_at).to be_within(3.seconds).of(Time.current)

      expect do
        record_2.unarchive
      end.to change { record_2.archived_at }.to(nil)

      expect(record_2).to_not be_archived
      expect(record_2.archived_at).to be_nil
    end

    it 'archives dependents' do
      dependents = described_class.instance_variable_get('@archive_dependents')
      dependents&.each do |dependent|
        dependent_name = dependent.to_s.singularize
        record_1.send(dependent) << create(dependent_name)
        record_1.archive

        expect(record_1.send(dependent).first).to be_archived
      end
    end

    it 'unarchives dependents' do
      dependents = described_class.instance_variable_get('@archive_dependents')
      dependents&.each do |dependent|
        dependent_name = dependent.to_s.singularize
        record_1.send(dependent) << create(dependent_name)
        record_1.unarchive

        expect(record_1.send(dependent).first).to_not be_archived
      end
    end
  end
end
