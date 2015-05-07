# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 15) do

  create_table "addresses", :force => true do |t|
    t.string   "name"
    t.text     "line1"
    t.text     "line2"
    t.string   "city"
    t.string   "state"
    t.string   "pincode"
    t.string   "phone_number"
    t.integer  "is_primary",   :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "order_logs", :force => true do |t|
    t.integer  "order_id"
    t.string   "event"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.datetime "slot_start_time",   :null => false
    t.string   "status",            :null => false
    t.datetime "actual_start_time"
    t.datetime "actual_end_time"
    t.integer  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id",        :null => false
    t.integer  "service_id",        :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price_per_hour", :precision => 12, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image"
  end

  create_table "users", :force => true do |t|
    t.string   "email_id"
    t.string   "password"
    t.string   "gender"
    t.string   "login_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "veteran_slots", :force => true do |t|
    t.integer  "veteran_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "is_reserved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "veterans", :force => true do |t|
    t.integer  "service_id"
    t.string   "name"
    t.integer  "contact_number"
    t.integer  "pan"
    t.text     "address"
    t.text     "languages_known"
    t.string   "agency"
    t.integer  "expected_service_minutes"
    t.integer  "expected_travel_minutes_before"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
