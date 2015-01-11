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

ActiveRecord::Schema.define(version: 20150111204611) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "doc_url"
    t.integer  "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "articles", ["entry_id"], name: "index_articles_on_entry_id"

  create_table "attendances", force: :cascade do |t|
    t.integer  "entry_id"
    t.integer  "number"
    t.string   "join_yn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["entry_id"], name: "index_attendances_on_entry_id"

  create_table "entries", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.integer  "progress_percent"
  end

  create_table "progresses", force: :cascade do |t|
    t.integer  "percentage"
    t.integer  "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "progresses", ["entry_id"], name: "index_progresses_on_entry_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["title"], name: "index_projects_on_title", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "passwd"
    t.string   "name"
    t.string   "nick"
    t.integer  "grade"
    t.string   "permisson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["nick"], name: "index_users_on_nick", unique: true

end
