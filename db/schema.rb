# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 20180908232433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accessories", force: :cascade do |t|
    t.string "image"
    t.string "title"
    t.string "description"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "conditions", force: :cascade do |t|
    t.datetime "date"
    t.float "max_temp"
    t.float "mean_temp"
    t.float "min_temp"
    t.float "mean_humidity"
    t.float "mean_visibility"
    t.float "mean_wind_speed"
    t.float "precip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.string "installation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.bigint "start_station_id"
    t.datetime "end_date"
    t.bigint "end_station_id"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_station_id"], name: "index_trips_on_end_station_id"
    t.index ["start_station_id"], name: "index_trips_on_start_station_id"
  end

  add_foreign_key "trips", "stations", column: "end_station_id"
  add_foreign_key "trips", "stations", column: "start_station_id"
end
