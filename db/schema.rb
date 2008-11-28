# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "customers", :force => true do |t|
    t.string "name",                      :null => false
    t.string "nif"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "private_key", :limit => 32
  end

  create_table "invoice_lines", :force => true do |t|
    t.integer "invoice_id"
    t.integer "quantity",                                  :default => 1
    t.string  "description"
    t.decimal "price",       :precision => 8, :scale => 2, :default => 0.0
  end

  create_table "invoices", :force => true do |t|
    t.integer "customer_id"
    t.date    "date"
    t.integer "fiscal_year"
    t.integer "number"
    t.decimal "irpf",        :precision => 8, :scale => 2, :default => 15.0
    t.decimal "iva",         :precision => 8, :scale => 2, :default => 16.0
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "nif"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
