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

ActiveRecord::Schema.define(version: 2018_10_10_105501) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.integer "currency_id"
    t.boolean "is_bank_account"
    t.integer "bank_account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_accounts_on_company_id"
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["discarded_at"], name: "index_accounts_on_discarded_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "parent_category_id"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_categories_on_discarded_at"
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_companies_on_discarded_at"
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
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_counter_parties_on_category_id"
    t.index ["discarded_at"], name: "index_counter_parties_on_discarded_at"
    t.index ["district_id"], name: "index_counter_parties_on_district_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "precision", default: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_currencies_on_discarded_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_departments_on_company_id"
    t.index ["discarded_at"], name: "index_departments_on_discarded_at"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.integer "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_districts_on_discarded_at"
    t.index ["district_id"], name: "index_districts_on_district_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.integer "department_id"
    t.integer "company_id"
    t.text "notes"
    t.boolean "gender"
    t.date "hire_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["discarded_at"], name: "index_employees_on_discarded_at"
  end

  create_table "price_category", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_price_category_on_discarded_at"
  end

  create_table "product_price_histories", force: :cascade do |t|
    t.datetime "date"
    t.float "price"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency_id"
    t.integer "price_category_id"
    t.datetime "discarded_at"
    t.index ["currency_id"], name: "index_product_price_histories_on_currency_id"
    t.index ["discarded_at"], name: "index_product_price_histories_on_discarded_at"
    t.index ["price_category_id"], name: "index_product_price_histories_on_price_category_id"
    t.index ["product_id"], name: "index_product_price_histories_on_product_id"
  end

  create_table "production_items", force: :cascade do |t|
    t.integer "production_id", null: false
    t.integer "product_id", null: false
    t.integer "amount", null: false
    t.index ["product_id"], name: "index_production_items_on_product_id"
    t.index ["production_id"], name: "index_production_items_on_production_id"
  end

  create_table "productions", force: :cascade do |t|
    t.date "date", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_productions_on_discarded_at"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.boolean "is_for_sale", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["discarded_at"], name: "index_products_on_discarded_at"
  end

  create_table "purchase_items", force: :cascade do |t|
    t.integer "purchase_id", null: false
    t.integer "product_id", null: false
    t.integer "amount", null: false
    t.float "price", null: false
    t.index ["product_id"], name: "index_purchase_items_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_items_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "currency_id"
    t.date "date", null: false
    t.integer "supplier_id"
    t.float "discount"
    t.integer "created_by_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_purchases_on_created_by_id"
    t.index ["currency_id"], name: "index_purchases_on_currency_id"
    t.index ["discarded_at"], name: "index_purchases_on_discarded_at"
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
  end

  create_table "salaries", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "department_id"
    t.date "from_date"
    t.integer "salary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["department_id"], name: "index_salaries_on_department_id"
    t.index ["discarded_at"], name: "index_salaries_on_discarded_at"
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  create_table "sale_items", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "amount", null: false
    t.float "price", null: false
    t.integer "sale_id"
    t.index ["product_id"], name: "index_sale_items_on_product_id"
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "currency_id", null: false
    t.integer "customer_id"
    t.date "date", null: false
    t.float "discount"
    t.integer "created_by_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_sales_on_created_by_id"
    t.index ["currency_id"], name: "index_sales_on_currency_id"
    t.index ["customer_id"], name: "index_sales_on_customer_id"
    t.index ["discarded_at"], name: "index_sales_on_discarded_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.text "notes"
    t.float "amount"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_id"
    t.integer "counter_party_id"
    t.float "coefficient"
    t.integer "account_id"
    t.integer "reference_id"
    t.string "reference_type"
    t.integer "counter_account_id"
    t.float "rate"
    t.datetime "discarded_at"
    t.integer "asked_currency_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["asked_currency_id"], name: "index_transactions_on_asked_currency_id"
    t.index ["counter_party_id"], name: "index_transactions_on_counter_party_id"
    t.index ["discarded_at"], name: "index_transactions_on_discarded_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer "employee_id"
    t.datetime "discarded_at"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

end
