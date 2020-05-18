# README

## Setup
1. rails db:create
2. rails db:migrate
3. rails db:seed
4. rails s

## Demo Site
* https://vehico-listo.herokuapp.com

## Notes
* There is no focus on UI for the application
* Roles can be user, sales_rep or technician for now but can be easily extended
* The database architecture uses common e-commerce database patterns and aims at providing flexibility and extensibility
* The pricing is separated from Variant model since the similar seeming vehicles can have different pricing based on vehicle grade, mileage or other vehicle conditions
* StockItem is separated from StockLocation since the car can be moved around on the basis of demand. Later on, concept of stock_transfer, and stock_movement can be introduced indicate if a stock is in transmit between stock locations
* Did not introduce foreign_key and not null constraints as of now. This is better maintained at application level initially and can be moved to database systems as the data grows
* Uses Pagy gem which is much more efficient than Kaminari, Will_Paginate gems

## Questions
* It is not clear how sales rep and buyer will be mapped to a stock item. Does sales rep comes into picture only after a purchase in our system? Or does each stock item has a sales representative and an owner?
* How does dealer link with a stock item? Is dealer the owner of vehicle or the user is?
* How is end_date significant?
* What is the significance of stocknumber?
* Are the SalesRep, WtchedBy and BuyerName some unique Ids for each?

## Assumptions
* ABGLOCATION is Vehicle Stock Location
* WatchedBy is the Technician who inspected the vehicle
* SalesRep and Buyer are Unique Ids
* Default location is considered `USA`

## Improvements
* Search and filtering performance can be greatly improved by using elasticsearch
* Currently assuming that each user has only one one role. We can create different users with same email but different roles or can convert the mapping as many-to-many between users and roles later if desired
* activerecord_import gem can be used to improve the performance of writing records. It's a good gem for bulk inserts
* Currently there is no authentication and authorization logic in the system. Anyone can import records
* Imports can and should be done via background processing as the task can be time consuming. The import file should be persisted for sometime in a persistent storage in case of server crashes.
* Further improvements can be made using inverse_of relationships
* Any database related logic like foreign keys, dependent_destroy, etc are not added and can be evolved
* Can create a model for Import to keep a track of all the imports
* Can add another attribute `is_master` to Variant. Master Variant will be used to refer basic details for vehicle like make, body, model (corresponding columns also to be added to variant). This makes all processing around Variants in the system
* Further analysis shall be required depending on what fields we can be expecting as nil in CSV

## Overall Architecture for DB
* User: id, name, email, role_id (can represent customer, sales_rep, technician)
* Role: id, name (customer, sales_rep, technician)
* Dealer: id, name

* Make: id, name, has_many :vehicles (or models)
* VehicleType: id, name
* VehicleSpecification: id, vehicle_id, cylinder,  displacement, transmission, drive_train
* Vehicle: id, model, vehichle_type_id, make_id, has_many :variants (has_many :model_variants, has_many :vehicle_specifications)
* ModelVariant: id, vehicle_id, series, year

* OptionType: id, name, has_many :values 
  upholstery, interior_colour, exterior_colour, ...( can be extended eg sunroof, accessories)
* OptionValue: id, option_type_id, value
* OptionValueVariant
* Variants: has_one :inspection, vehicle_id, vehicle_specification_id, model_variant_id, has_many :option_variants, through: :option_value_variant


* StockLocation: id, name, city, province, country
* StockItem: id, vin, variant_id, vehicle_id, dealer_id
* Inspection: grade, condition_report_url, watched_by, mileage, stock_item_id
* Price :variant_id, stock_item_id, amount_cents, amount_currency

* Purchase :id, variant_id, customer_id, sales_rep_id
