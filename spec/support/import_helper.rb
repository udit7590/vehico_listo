module ImportHelper
  def import_vehicles_list(file_name = 'vehicles_list_1.csv')
    ImporterService.new(file: Rails.root.join('spec', 'fixtures', file_name), format: 'csv').import
  end
end
