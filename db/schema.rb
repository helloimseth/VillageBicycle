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

ActiveRecord::Schema.define(version: 20150311174155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_ons", force: :cascade do |t|
    t.integer  "bike_id"
    t.integer  "extra_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "add_ons", ["bike_id"], name: "index_add_ons_on_bike_id", using: :btree
  add_index "add_ons", ["extra_id"], name: "index_add_ons_on_extra_id", using: :btree

  create_table "bikes", force: :cascade do |t|
    t.integer  "owner_id",     null: false
    t.string   "name",         null: false
    t.text     "notes"
    t.string   "gender",       null: false
    t.integer  "size_id",      null: false
    t.integer  "num_gears",    null: false
    t.integer  "hourly_price", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "extras", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size",             null: false
    t.string "frame_size",       null: false
    t.string "suggested_height", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "password_digest",  null: false
    t.string   "session_token",    null: false
    t.string   "fname",            null: false
    t.string   "lname",            null: false
    t.text     "bio"
    t.string   "address"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "size_id"
    t.integer  "neighborhood_id"
    t.boolean  "activated"
    t.string   "activation_token"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
