FactoryBot.define do
  factory :variant do
    vehicle_specification
    model_variant

    transient do
      build_option_values { nil }
    end

    before(:create, :build) do |variant, evaluator|
      if evaluator.build_option_values.present?
        if evaluator.build_option_values.is_a? Array
          evaluator.build_option_values.each do |option_value|
            variant.option_value_variants.build(option_value: option_value)
          end
        else
          variant.option_value_variants.build(option_value: evaluator.build_option_values)
        end
      end
    end
  end
end
