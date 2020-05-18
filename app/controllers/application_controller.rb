class ApplicationController < ActionController::Base
  include Pagy::Backend

  protected

    def filtered(association)
      hash = filter_params.to_h
      association.apply_filters(hash)
    end
end
