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

ActiveRecord::Schema.define(version: 20150831073459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "subscription_requests", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscription_requests", ["email"], name: "index_subscription_requests_on_email", using: :btree
  add_index "subscription_requests", ["token"], name: "index_subscription_requests_on_token", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email",             null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "last_sent_at"
    t.datetime "last_delivered_at"
  end

end
