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

ActiveRecord::Schema.define(version: 20171215161226) do

  create_table "product_items", force: :cascade do |t|
    t.string   "seller"
    t.date     "date_created"
    t.date     "date_sold"
    t.integer  "user_id"
    t.integer  "seller_id"
    t.integer  "product_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sold",            default: false, null: false
  end

  create_table "product_lines", force: :cascade do |t|
    t.string   "product_name"
    t.string   "type"
    t.float    "cost_to_make"
    t.float    "sale_price"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seller_product_lines", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "seller_id"
    t.integer  "product_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sellers", force: :cascade do |t|
    t.string   "seller_name"
    t.date     "start_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
