# This class is mainly used to import external data into the vehico_listo system
# Examples can be CSV, Google Sheets, Excel, URL, Another DB, etc
class ImporterService
  attr_reader :format, :file, :options

  # Options can be specific to different formats
  def initialize(file: , format: , options: {})
    @file     = file
    @format   = format
    @options  = options
  end

  def format_klass
    case format.to_s.downcase
    when 'csv' then ImporterService::Format::Csv
    end
  end

  def import
    return unless enabled?

    count = 0
    format_klass.new(file: file, options: options).import do |vehicles|
      if vehicles.is_a?(Array)
        count += batch_import_vehicles(vehicles)
      else
        count += 1 if (import_vehicle(vehicles) > 0)
      end
    end

    count
  end

  # This can have the logic to enable/disable an import service
  def enabled?
    true
  end

  private
    # Accepts vehicles has in a specific format.
    # It is the responsibility of the `format_klass` to read the data according to its format and return results
    # => in the format expected by the original service. Results can be processed in batches and returned using block yield
    # Expected Row Format:
    # {
    #   vin: 'sample',
    #   grade: 4.2,
    #   stock_number: 'sample',
    #   make: 'sample',
    #   model: 'sample',
    #   series: 'sample',
    #   year: 1980,
    #   price_cents: 10000,
    #   body: 'sample',
    #   cylinders: 'sample',
    #   displacement: 'sample',
    #   exterior_colour: 'sample',
    #   interior_colour: 'sample',
    #   mileage: 4200, # in KM
    #   transmission: 'sample',
    #   upholstery: 'sample',
    #   end_date: DateTime.now,
    #   stock_location_city: 'San Francisco',
    #   stock_location_province: 'CA',
    #   stock_location_country: 'USA',
    #   buy_date: DateTime.now,
    #   customer: 'sample',
    #   inspected_by: 'sample',
    #   dealer_name: 'sample',
    #   drive_train: 'sample',
    #   condition_report: 'sample',
    #   sales_rep: 'sample'
    # }

    # IMPROVEMENTS: REFACTOR_ME
    # This importer can also be split into individual model importer services depending on features in future
    def import_vehicle(vehicle)
      flag = false
      ApplicationRecord.transaction do

        # ----------------------------------------
        # STEP 1: Create any dependent Rcords
        # ----------------------------------------
        make = Make.find_or_create_by(name: vehicle[:make])

        option_values = permitted_option_types.map do |option_type|
          option_type_record = OptionType.find_or_create_by(name: option_type)
          option_type_record.option_values.find_or_create_by(value: vehicle[option_type]) if vehicle[option_type]
        end.select(&:present?)

        vehicle_type = VehicleType.find_or_create_by(name: vehicle[:body])

        vehicle_specification = VehicleSpecification.find_or_create_by({
          cylinders: vehicle[:cylinders],
          displacement: vehicle[:displacement],
          transmission: vehicle[:transmission],
          drive_train: vehicle[:drive_train]
        })

        model_variant = ModelVariant.find_or_create_by(series: vehicle[:series], year: vehicle[:year])

        stock_location = StockLocation.find_or_create_by({
          city: vehicle[:stock_location_city],
          province: vehicle[:stock_location_province],
          country: vehicle[:stock_location_country],
        })

        dealer = (Dealer.find_or_create_by(name: vehicle[:dealer_name]) if vehicle[:dealer_name].present?)

        vehicle_obj = Vehicle.find_or_create_by(model: vehicle[:model], make: make, vehicle_type: vehicle_type)

        # ----------------------------------------
        # STEP 2: Build Variant Specific Data
        # ----------------------------------------

        existing_variants = Variant.includes(option_value_variants: :option_value).where(
          vehicle: vehicle_obj,
          vehicle_specification: vehicle_specification,
          model_variant: model_variant,
          option_value_variants: { option_value: option_values }
        )
        variant = existing_variants.first_or_initialize
        unless variant.persisted?
          option_values.map { |option_value| variant.option_value_variants.build(option_value: option_value) }
        end
        variant.save!
      
        # ----------------------------------------
        # STEP 3: Build Stock Item Specific Data
        # ----------------------------------------

        stock_item = StockItem.find_or_initialize_by(
          vin: vehicle[:vin]
        )
        stock_item.assign_attributes({
          stock_location: stock_location,
          dealer: dealer,
          variant: variant
        })

        stock_item.vehicle_inspection || stock_item.build_vehicle_inspection
        stock_item.vehicle_inspection.assign_attributes({
          grade: vehicle[:grade],
          condition_report_url: vehicle[:condition_report],
          mileage: vehicle[:mileage],
          watched_by: vehicle[:inspected_by],
          variant: variant
        })

        stock_item.price || stock_item.build_price
        stock_item.price.assign_attributes({
          amount_currency: Price::DEFAULT_CURRENCY,
          amount_cents: vehicle[:price_cents],
          variant: variant
        })

        if vehicle[:customer].present?
          customer = User.find_or_initialize_by(email: vehicle[:customer], role: Role.user)
          sales_rep = User.find_or_initialize_by(email: vehicle[:sales_rep], role: Role.sales_rep)

          stock_item.purchase || stock_item.build_purchase
          stock_item.purchase.assign_attributes({
            amount_currency: Price::DEFAULT_CURRENCY,
            amount_cents: vehicle[:price_cents],
            variant: variant,
            customer: customer,
            sales_rep: sales_rep
          })
        end

        if stock_item.persisted?
          stock_item.save!
        else
          stock_item.save!
          flag = true
        end
      end

      flag ? 1 : 0
    end

    # IMPROVEMENTS: This can be used to improve efficiency of imports later on
    # => Aim to use ActiveImport gem
    def batch_import_vehicles(vehicles)
      vehicles.map { |vehicle| import_vehicle(vehicle) }.sum
    end

    def permitted_option_types
      OptionType::DEFAULT_TYPES
    end
end
