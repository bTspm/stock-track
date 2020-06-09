# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you"ll amass, the slower it"ll run and the greater likelihood for issues).
#
# It"s strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_220_010_946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.citext "line_1", null: false
    t.citext "line_2"
    t.citext "city"
    t.citext "state"
    t.citext "country", null: false
    t.citext "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_addresses_on_country"
    t.index ["state"], name: "index_addresses_on_state"
  end

  create_table "companies", force: :cascade do |t|
    t.citext "symbol", null: false
    t.citext "name", null: false
    t.citext "security_name", null: false
    t.citext "sector", null: false
    t.citext "industry", null: false
    t.bigint "address_id"
    t.citext "phone"
    t.integer "employees"
    t.citext "website"
    t.text "description"
    t.integer "sic_code"
    t.bigint "exchange_id", null: false
    t.bigint "issuer_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_companies_on_address_id"
    t.index ["exchange_id"], name: "index_companies_on_exchange_id"
    t.index ["industry"], name: "index_companies_on_industry"
    t.index ["issuer_type_id"], name: "index_companies_on_issuer_type_id"
    t.index ["sector"], name: "index_companies_on_sector"
    t.index %w[symbol exchange_id], name: "index_companies_on_symbol_and_exchange_id", unique: true
  end

  create_table "company_executives", force: :cascade do |t|
    t.integer "age"
    t.bigint "compensation"
    t.citext "currency"
    t.citext "name", null: false
    t.integer "since"
    t.text "titles", default: [], array: true
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_executives_on_company_id"
    t.index ["currency"], name: "index_company_executives_on_currency"
    t.index ["name"], name: "index_company_executives_on_name"
    t.index ["since"], name: "index_company_executives_on_since"
    t.index ["titles"], name: "index_company_executives_on_titles"
  end

  create_table "exchanges", force: :cascade do |t|
    t.citext "code", null: false
    t.citext "country", null: false
    t.citext "name", null: false
    t.index %w[code country], name: "index_exchanges_on_code_and_country", unique: true
    t.index ["country"], name: "index_exchanges_on_country"
  end

  create_table "issuer_types", force: :cascade do |t|
    t.citext "code", null: false
    t.citext "name", null: false
    t.index ["code"], name: "index_issuer_types_on_code", unique: true
    t.index ["name"], name: "index_issuer_types_on_name", unique: true
  end

  add_foreign_key "companies", "addresses"
  add_foreign_key "companies", "exchanges"
  add_foreign_key "companies", "issuer_types"
  add_foreign_key "company_executives", "companies"
end
