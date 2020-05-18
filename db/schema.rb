# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_18_144452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dealers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "makes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "model_variants", force: :cascade do |t|
    t.string "series"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "option_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "option_value_variants", force: :cascade do |t|
    t.bigint "variant_id"
    t.bigint "option_value_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_value_id"], name: "index_option_value_variants_on_option_value_id"
    t.index ["variant_id"], name: "index_option_value_variants_on_variant_id"
  end

  create_table "option_values", force: :cascade do |t|
    t.string "value"
    t.bigint "option_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_type_id"], name: "index_option_values_on_option_type_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "stock_item_id"
    t.bigint "variant_id"
    t.string "amount_currency"
    t.integer "amount_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_item_id"], name: "index_prices_on_stock_item_id"
    t.index ["variant_id"], name: "index_prices_on_variant_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "variant_id"
    t.bigint "stock_item_id"
    t.bigint "customer_id"
    t.bigint "sales_rep_id"
    t.integer "amount_cents"
    t.string "amount_currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_purchases_on_customer_id"
    t.index ["sales_rep_id"], name: "index_purchases_on_sales_rep_id"
    t.index ["stock_item_id"], name: "index_purchases_on_stock_item_id"
    t.index ["variant_id"], name: "index_purchases_on_variant_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stock_items", force: :cascade do |t|
    t.string "vin"
    t.bigint "variant_id"
    t.bigint "stock_location_id"
    t.bigint "dealer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dealer_id"], name: "index_stock_items_on_dealer_id"
    t.index ["stock_location_id"], name: "index_stock_items_on_stock_location_id"
    t.index ["variant_id"], name: "index_stock_items_on_variant_id"
  end

  create_table "stock_locations", force: :cascade do |t|
    t.string "city"
    t.string "province"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "vehicle_specification_id"
    t.bigint "model_variant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["model_variant_id"], name: "index_variants_on_model_variant_id"
    t.index ["vehicle_id"], name: "index_variants_on_vehicle_id"
    t.index ["vehicle_specification_id"], name: "index_variants_on_vehicle_specification_id"
  end

  create_table "vehicle_inspections", force: :cascade do |t|
    t.decimal "grade", precision: 4, scale: 2
    t.string "condition_report_url"
    t.integer "mileage"
    t.bigint "watched_by_id"
    t.bigint "stock_item_id"
    t.bigint "variant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_item_id"], name: "index_vehicle_inspections_on_stock_item_id"
    t.index ["variant_id"], name: "index_vehicle_inspections_on_variant_id"
    t.index ["watched_by_id"], name: "index_vehicle_inspections_on_watched_by_id"
  end

  create_table "vehicle_specifications", force: :cascade do |t|
    t.string "cylinders"
    t.string "displacement"
    t.string "transmission"
    t.string "drive_train"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "model"
    t.bigint "vehicle_type_id"
    t.bigint "make_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["make_id"], name: "index_vehicles_on_make_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

end
