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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121009201106) do

  create_table "product_natures", :force => true do |t|
    t.string  "name",             :null => false
    t.text    "description"
    t.string  "payment_sequence"
    t.integer "initial_quantity"
    t.integer "current_quantity"
  end

  create_table "products", :force => true do |t|
    t.integer "nature_id",                                  :null => false
    t.string  "name",                                       :null => false
    t.text    "description"
    t.integer "arity"
    t.decimal "amount",      :precision => 16, :scale => 2
  end

  add_index "products", ["nature_id"], :name => "index_products_on_nature_id"

  create_table "residents", :force => true do |t|
    t.integer "sale_id",              :null => false
    t.string  "last_name",            :null => false
    t.string  "first_name",           :null => false
    t.date    "birth_on"
    t.string  "club"
    t.text    "address"
    t.string  "phone"
    t.string  "email"
    t.string  "identity_number"
    t.date    "identity_valid_until"
  end

  add_index "residents", ["sale_id"], :name => "index_residents_on_sale_id"

  create_table "sales", :force => true do |t|
    t.integer "product_id",                                      :null => false
    t.string  "number"
    t.decimal "amount",           :precision => 16, :scale => 2
    t.string  "state"
    t.string  "error_code"
    t.string  "payment_sequence"
    t.text    "payment_infos"
    t.text    "log"
  end

  add_index "sales", ["product_id"], :name => "index_sales_on_product_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
