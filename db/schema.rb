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

ActiveRecord::Schema.define(version: 20161124171402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ordered_parcels", force: :cascade do |t|
    t.integer  "parcel_id"
    t.integer  "shipment_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "parcels", force: :cascade do |t|
    t.string   "awb"
    t.string   "description"
    t.string   "remark"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "weight"
    t.integer  "volume"
    t.integer  "status"
    t.integer  "parcel_good"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "remark"
    t.integer  "weight"
    t.integer  "volume"
    t.integer  "status"
    t.integer  "type"
    t.decimal  "charge"
    t.string   "bill_id"
    t.datetime "due_at"
    t.datetime "paid_at"
    t.string   "bill_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "address"
    t.integer  "postcode"
    t.integer  "phone"
    t.integer  "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "address2"
  end

end
