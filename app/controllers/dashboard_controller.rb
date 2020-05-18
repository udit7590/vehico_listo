class DashboardController < ApplicationController
  def index
    @pagy, @variants = pagy(Variant.all.includes(
      :vehicle_specification,
      :model_variant,
      :prices,
      option_values: [:option_type],
      vehicle: [:make, :vehicle_type]
    ))
  end
end
