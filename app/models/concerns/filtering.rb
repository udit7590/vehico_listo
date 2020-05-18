module Filtering
  extend ActiveSupport::Concern

  class_methods do
    def filter_by(name, scope_lambda)
      register_filter(name)
      scope(:"filter_by_#{name}", scope_lambda)
    end

    private
      def register_filter(name)
        @filters ||= Set.new
        @filters << name.to_s
      end
  end

  included do
    scope :filter?, -> (name) do
      @filters.include?(name.to_s)
    end

    scope :apply_filters, -> (params) do
      filter_params = params.select { |k, v| !v.to_s.empty? && (klass.respond_to?(:"filter_by_#{k}")) }

      filter_params.reduce(self) do |chain, (name, value)|
        filter_method = :"filter_by_#{name}"
        chain.send(filter_method, value)
      end
    end
  end
end
