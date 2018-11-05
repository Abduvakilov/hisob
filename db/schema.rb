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

ActiveRecord::Schema.define(version: 2018_11_05_075431) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id"
    t.bigint "currency_id"
    t.boolean "enable_overdraft"
    t.integer "bank_account_number"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_accounts_on_company_id"
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["discarded_at"], name: "index_accounts_on_discarded_at"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "parent_category_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_categories_on_discarded_at"
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "short_name"
    t.string "long_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_companies_on_discarded_at"
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "counter_party_id"
    t.bigint "category_id"
    t.bigint "currency_id"
    t.date "start_date"
    t.date "due_date"
    t.datetime "discarded_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_contracts_on_category_id"
    t.index ["counter_party_id"], name: "index_contracts_on_counter_party_id"
    t.index ["currency_id"], name: "index_contracts_on_currency_id"
    t.index ["discarded_at"], name: "index_contracts_on_discarded_at"
  end

  create_table "counter_parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "short_name"
    t.string "company_name"
    t.string "primary_person"
    t.string "phone"
    t.string "email"
    t.bigint "district_id"
    t.bigint "category_id"
    t.boolean "is_supplier"
    t.boolean "is_customer"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_counter_parties_on_category_id"
    t.index ["discarded_at"], name: "index_counter_parties_on_discarded_at"
    t.index ["district_id"], name: "index_counter_parties_on_district_id"
    t.index ["is_customer"], name: "index_counter_parties_on_is_customer"
    t.index ["is_supplier"], name: "index_counter_parties_on_is_supplier"
  end

  create_table "currencies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "precision", default: 2
    t.boolean "is_main"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_currencies_on_discarded_at"
    t.index ["is_main"], name: "index_currencies_on_is_main"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_departments_on_company_id"
    t.index ["discarded_at"], name: "index_departments_on_discarded_at"
  end

  create_table "districts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "parent_district_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_districts_on_discarded_at"
    t.index ["parent_district_id"], name: "index_districts_on_parent_district_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.date "hire_date"
    t.bigint "department_id"
    t.bigint "company_id"
    t.text "notes"
    t.boolean "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["discarded_at"], name: "index_employees_on_discarded_at"
  end

  create_table "prices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "product_id"
    t.bigint "category_id"
    t.float "price"
    t.bigint "currency_id"
    t.bigint "price_category_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_prices_on_category_id"
    t.index ["currency_id"], name: "index_prices_on_currency_id"
    t.index ["discarded_at"], name: "index_prices_on_discarded_at"
    t.index ["price_category_id"], name: "index_prices_on_price_category_id"
    t.index ["product_id"], name: "index_prices_on_product_id"
  end

  create_table "production_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "production_id", null: false
    t.bigint "product_id", null: false
    t.integer "amount", null: false
    t.index ["product_id"], name: "index_production_items_on_product_id"
    t.index ["production_id"], name: "index_production_items_on_production_id"
  end

  create_table "productions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date", null: false
    t.datetime "discarded_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_productions_on_discarded_at"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "unit_id"
    t.boolean "include_base_unit"
    t.bigint "company_id"
    t.bigint "counter_party_id"
    t.boolean "is_for_sale"
    t.bigint "category_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["counter_party_id"], name: "index_products_on_counter_party_id"
    t.index ["discarded_at"], name: "index_products_on_discarded_at"
    t.index ["is_for_sale"], name: "index_products_on_is_for_sale"
    t.index ["unit_id"], name: "index_products_on_unit_id"
  end

  create_table "purchase_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.bigint "product_id", null: false
    t.integer "amount", null: false
    t.float "price", null: false
    t.index ["product_id"], name: "index_purchase_items_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_items_on_purchase_id"
  end

  create_table "purchases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "datetime", null: false
    t.bigint "contract_id", null: false
    t.float "discount"
    t.datetime "discarded_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_purchases_on_contract_id"
    t.index ["discarded_at"], name: "index_purchases_on_discarded_at"
  end

  create_table "salaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "from_date"
    t.float "salary", null: false
    t.bigint "employee_id"
    t.bigint "department_id"
    t.bigint "currency_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["currency_id"], name: "index_salaries_on_currency_id"
    t.index ["department_id"], name: "index_salaries_on_department_id"
    t.index ["discarded_at"], name: "index_salaries_on_discarded_at"
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  create_table "sale_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "amount", null: false
    t.float "price", null: false
    t.bigint "sale_id"
    t.index ["product_id"], name: "index_sale_items_on_product_id"
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
  end

  create_table "sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.datetime "datetime", null: false
    t.float "discount"
    t.text "notes"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_sales_on_contract_id"
    t.index ["discarded_at"], name: "index_sales_on_discarded_at"
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "datetime", null: false
    t.float "amount", null: false
    t.integer "type_id", limit: 1, null: false
    t.bigint "counter_party_id"
    t.bigint "employee_id"
    t.bigint "contract_id"
    t.float "accepted_as_amount"
    t.bigint "accepted_as_currency_id"
    t.bigint "account_id"
    t.bigint "counter_account_id"
    t.float "rate"
    t.bigint "asked_currency_id"
    t.text "notes"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_as_currency_id"], name: "index_transactions_on_accepted_as_currency_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["asked_currency_id"], name: "index_transactions_on_asked_currency_id"
    t.index ["contract_id"], name: "index_transactions_on_contract_id"
    t.index ["counter_account_id"], name: "index_transactions_on_counter_account_id"
    t.index ["counter_party_id"], name: "index_transactions_on_counter_party_id"
    t.index ["discarded_at"], name: "index_transactions_on_discarded_at"
    t.index ["employee_id"], name: "index_transactions_on_employee_id"
    t.index ["type_id"], name: "index_transactions_on_type_id"
  end

  create_table "units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "short_name", null: false
    t.string "long_name", null: false
    t.bigint "base_unit_id"
    t.float "ratio_to_base_unit"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_unit_id"], name: "index_units_on_base_unit_id"
    t.index ["discarded_at"], name: "index_units_on_discarded_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employee_id"
    t.datetime "discarded_at"
    t.boolean "is_admin"
    t.text "notes"
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

  add_foreign_key "accounts", "companies"
  add_foreign_key "accounts", "currencies"
  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "contracts", "categories"
  add_foreign_key "contracts", "counter_parties"
  add_foreign_key "contracts", "currencies"
  add_foreign_key "counter_parties", "categories"
  add_foreign_key "counter_parties", "districts"
  add_foreign_key "departments", "companies"
  add_foreign_key "districts", "districts", column: "parent_district_id"
  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "departments"
  add_foreign_key "prices", "categories"
  add_foreign_key "prices", "categories", column: "price_category_id"
  add_foreign_key "prices", "currencies"
  add_foreign_key "prices", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "counter_parties"
  add_foreign_key "purchases", "contracts"
  add_foreign_key "salaries", "currencies"
  add_foreign_key "salaries", "departments"
  add_foreign_key "salaries", "employees"
  add_foreign_key "sale_items", "products"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sales", "contracts"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "accounts", column: "counter_account_id"
  add_foreign_key "transactions", "contracts"
  add_foreign_key "transactions", "counter_parties"
  add_foreign_key "transactions", "currencies", column: "accepted_as_currency_id"
  add_foreign_key "transactions", "currencies", column: "asked_currency_id"
  add_foreign_key "transactions", "employees"
  add_foreign_key "units", "units", column: "base_unit_id"
  add_foreign_key "users", "employees"
end
