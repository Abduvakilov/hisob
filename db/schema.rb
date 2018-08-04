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

ActiveRecord::Schema.define(version: 2018_07_23_131615) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.integer "currency_id"
    t.boolean "is_bank_account"
    t.integer "bank_account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_accounts_on_company_id"
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "parent_category_id"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counter_parties", force: :cascade do |t|
    t.string "name"
    t.string "company_name"
    t.string "phone"
    t.string "email"
    t.integer "district_id"
    t.integer "category_id"
    t.boolean "is_supplier"
    t.boolean "is_customer"
    t.boolean "is_active"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_counter_parties_on_category_id"
    t.index ["district_id"], name: "index_counter_parties_on_district_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "precision_to_show", default: 2
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.integer "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_districts_on_district_id"
  end

  create_table "price_category", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "product_price_histories", force: :cascade do |t|
    t.datetime "date"
    t.float "price"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency_id"
    t.integer "price_category_id"
    t.index ["currency_id"], name: "index_product_price_histories_on_currency_id"
    t.index ["price_category_id"], name: "index_product_price_histories_on_price_category_id"
    t.index ["product_id"], name: "index_product_price_histories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.boolean "is_for_sale", default: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.text "notes"
    t.float "amount"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_id"
    t.integer "counter_party_id"
    t.float "coefficient", default: 100.0
    t.integer "account_id"
    t.integer "reference_id"
    t.string "reference_type"
    t.integer "counter_account_id"
    t.float "rate"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["counter_party_id"], name: "index_transactions_on_counter_party_id"
  end

end
