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

ActiveRecord::Schema.define(version: 20150414180938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "microposts", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
    t.boolean  "read"
    t.boolean  "match"
    t.string   "email"
    t.string   "sender_email"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "inform"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["micropost_id"], name: "index_votes_on_micropost_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

end
