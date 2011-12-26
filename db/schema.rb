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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111226003423) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uid"
  end

  create_table "cards", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.integer   "parent_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.integer   "grandparent_id"
  end

  add_index "cards", ["parent_id"], :name => "index_cards_on_parent_id"

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
