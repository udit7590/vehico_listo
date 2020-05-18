class ImportsController < ApplicationController
  def create
    @import = Import.new(import_params)
    if import_params[:attachment].present?
      @import.delay.upload
      redirect_to root_path, notice: "Vehicles stock list will be imported in the background"
    else
      redirect_to root_path, alert: "File not provided to import vehicles"
    end
    
  end

  private
    def import_params
      if params[:import].present?
        params.require(:import).permit(:attachment)
      else
        {}
      end
    end
end
