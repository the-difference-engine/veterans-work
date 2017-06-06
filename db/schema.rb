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

ActiveRecord::Schema.define(version: 20170606001331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name"
    t.string   "zip_code"
    t.string   "phone"
    t.text     "description"
    t.string   "url"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.float    "service_radius"
    t.string   "status",                 default: "Pending"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_companies_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_companies_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true, using: :btree
  end

  create_table "companies_roles", id: false, force: :cascade do |t|
    t.integer "company_id"
    t.integer "role_id"
    t.index ["company_id", "role_id"], name: "index_companies_roles_on_company_id_and_role_id", using: :btree
  end

  create_table "company_services", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "service_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "quote_id"
    t.string   "customer_request_id"
  end

  create_table "customer_requests", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "service_category_id"
    t.text     "description"
    t.integer  "customer_id"
    t.date     "expires_date"
    t.float    "latitude"
    t.float    "longitude"
    t.index ["expires_date"], name: "index_customer_requests_on_expires_date", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_customers_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "quotes", force: :cascade do |t|
    t.integer  "customer_request_id"
    t.integer  "company_id"
    t.decimal  "materials_cost_estimate"
    t.decimal  "labor_cost_estimate"
    t.date     "start_date"
    t.date     "completion_date_estimate"
    t.text     "notes"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "accepted"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "company_id"
    t.integer  "stars"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "service_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
