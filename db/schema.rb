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

ActiveRecord::Schema.define(version: 20141011092357) do

  create_table "blogs", force: true do |t|
    t.integer "user_id"
    t.string  "content"
    t.date    "target_date"
  end

  add_index "blogs", ["user_id"], name: "index_blogs_on_user_id"

  create_table "indices", force: true do |t|
    t.date     "current_date"
    t.float    "closing_price"
    t.float    "opening_price"
    t.integer  "advance"
    t.integer  "decline"
    t.integer  "upshot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logins", force: true do |t|
    t.integer  "user_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logins", ["user_id"], name: "index_logins_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "mobile"
    t.string   "nickname"
    t.integer  "all_kill"
    t.integer  "month_correct"
    t.string   "memo"
    t.string   "passwd"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "score"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.date     "target_date"
    t.integer  "upshot"
    t.boolean  "correct"
    t.integer  "all_kill"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "score"
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
