class DashboardController < ApplicationController
  def index
    @pagy, @variants = pagy(filtered(Variant.all.includes(
      :vehicle_specification,
      :model_variant,
      :prices,
      option_values: [:option_type],
      vehicle: [:make, :vehicle_type]
    )))
  end

  private

    def filter_params
      params.permit(:size_id, :colour_id, :mileage_min, :mileage_max, :price_min, :price_max)
    end
end
