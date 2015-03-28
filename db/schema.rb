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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 10) do

  create_table "addresses", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "line1",        limit: 65535
    t.text     "line2",        limit: 65535
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "pincode",      limit: 255
    t.string   "phone_number", limit: 255
    t.integer  "is_primary",   limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id",  limit: 4
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email_id",   limit: 255
    t.string   "password",   limit: 255
    t.string   "gender",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.date     "slot_start_time"
    t.string   "status",            limit: 255
    t.date     "actual_start_time"
    t.date     "actual_end_time"
    t.integer  "total_price",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id",          limit: 4
  end

  create_table "services", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description",    limit: 65535
    t.integer  "price_per_hour", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "veteran_slots", force: :cascade do |t|
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "is_reserved", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "veteran_id",  limit: 4
  end

  create_table "veterans", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "phone_number",          limit: 255
    t.string   "pan_number",            limit: 255
    t.text     "address",               limit: 65535
    t.string   "languages_known",       limit: 255
    t.string   "agency",                limit: 255
    t.integer  "expected_service_time", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id",            limit: 4
  end

end
