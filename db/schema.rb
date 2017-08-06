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

ActiveRecord::Schema.define(version: 20170802122545) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "presence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "gender"
    t.integer  "people"
    t.string   "location"
    t.string   "company"
    t.string   "day"
    t.integer  "week"
    t.string   "lunchtime"
    t.boolean  "matched"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_joins_on_group_id"
    t.index ["user_id"], name: "index_joins_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "matchings", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_matchings_on_group_id"
    t.index ["meeting_id"], name: "index_matchings_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer  "date"
    t.string   "day"
    t.string   "lunchtime"
    t.string   "center"
    t.string   "pin_m"
    t.string   "pin_f"
    t.string   "p_count"
    t.string   "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "hits",       default: 0
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "password_digest"
    t.string   "age"
    t.string   "gender"
    t.string   "email"
    t.string   "company"
    t.string   "location"
    t.string   "lunchtime"
    t.string   "photo"
    t.string   "card"
    t.string   "token"
    t.boolean  "notice",          default: true
    t.boolean  "push",            default: true
    t.string   "push_token"
    t.boolean  "email_confirmed", default: false
    t.string   "confirm_token"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
