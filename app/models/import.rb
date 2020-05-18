class Import
  attr_accessor :attachment

  def initialize(params)
    @attachment = params[:attachment]
  end

  def upload
    service = ImporterService.new(file: attachment, format: 'csv')
    service.import
  end
end
