require 'csv'

class ImporterService::Format::Csv
  attr_reader :override, :file, :options

  def initialize(file: , options: {})
    @file     = file
    @override = override
    @options  = { headers: true }.merge(options)
  end

  # IMPROVEMENT: Can use `smarter_csv` gem to make bulk processing of CSV files
  def import
    CSV.open(file, headers: options[:headers]) do |vehicles|
      # NOTE: Keep the memory consumption low by using an enumerator when reading CSV
      vehicles_enum = vehicles.each
      vehicles_enum.each do |vehicle|
        yield normalize_row(vehicle.to_h)
      end
    end
  end

  private

    # Row Sample Data
    # {
    #   "VIN"=>"5XXGT4L34KG309345",
    #   "GRADE"=>"4.2",
    #   "STOCKNUMBER"=>nil,
    #   "MAKE"=>"Kia",
    #   "MODEL"=>"Optima",
    #   "SERIES"=>"Lx",
    #   "YEAR"=>"2019",
    #   "PRICE"=>"13700",
    #   "BODY"=>"Sedan",
    #   "CYLINDERS"=>"4",
    #   "DISPLACEMENT"=>"2.4l",
    #   "EXTERIOR"=>"Silver",
    #   "INTERIOR"=>"Black",
    #   "MILEAGE"=>"32716",
    #   "TRANSMISSION"=>"6-speed A/t",
    #   "UPHOLSTERY"=>"Cloth",
    #   "ENDDATE"=>"2020-02-24T19:30:00.000Z",
    #   "ABGLOCATION"=>"Jacksonville- FL",
    #   "BUYDATE"=>nil,
    #   "BUYERNAME"=>nil,
    #   "WATCHEDBY"=>nil,
    #   "DEALERSHIPNAME"=>nil,
    #   "DRIVE TRAIN"=>"FWD",
    #   "CONDITION REPORT"=>"http://crd.aiminspections.com/crd/PDFReport.aspx?report=DZ0TBxLnToFB5GgutRWZLDqZyFbXTMnwfJ0aYj9tTb5Io4uQ8uA5wbHbMVDTQjpfM4TdhZfH%2baJcnEA%2bhtUmEnzbO%2faSCad2sh%2fxppJ6g1URTvPy9V1lkQ%3d%3d",
    #   "SALES REP"=>nil
    # }
    def normalize_row(row)
      city, province, country = row['ABGLOCATION'].split('-').map(&:strip)
      {
        vin: row['VIN'],
        grade: row['GRADE'].to_f,
        stock_number: row['STOCKNUMBER'],
        make: row['MAKE'],
        model: row['MODEL'],
        series: row['SERIES'],
        year: row["YEAR"].presence && row["YEAR"].to_i,
        price_cents: row["PRICE"].to_i * 100, # Assuming price is there in USD and not cents
        body: row["BODY"],
        cylinders: row["CYLINDERS"],
        displacement: row["DISPLACEMENT"],
        exterior_colour: row["EXTERIOR"],
        interior_colour: row["INTERIOR"],
        mileage: row["MILEAGE"].to_i,
        transmission: row["TRANSMISSION"],
        upholstery: row["UPHOLSTERY"],
        end_date: row["ENDDATE"].presence && DateTime.parse(row["ENDDATE"]),
        stock_location_city: city,
        stock_location_province: province,
        stock_location_country: country || StockLocation::DEFAULT_LOCATION,
        buy_date: row["BUYDATE"].presence && DateTime.parse(row["BUYDATE"]),
        customer: row["BUYERNAME"],
        inspected_by: row["WATCHEDBY"],
        dealer_name: row["DEALERSHIPNAME"],
        drive_train: row["DRIVE TRAIN"],
        condition_report: row["CONDITION REPORT"],
        sales_rep: row["SALES REP"]
      }
    end
end
