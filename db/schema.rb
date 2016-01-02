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

ActiveRecord::Schema.define(version: 20160101104437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "article_name_th"
    t.string   "article_name_eng"
    t.integer  "issue_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "articles", ["issue_id"], name: "index_articles_on_issue_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "author_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "year"
    t.integer  "journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "issues", ["journal_id"], name: "index_issues_on_journal_id", using: :btree

  create_table "journals", force: :cascade do |t|
    t.string   "journal_name_th"
    t.string   "journal_name_eng"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_foreign_key "articles", "issues"
  add_foreign_key "issues", "journals"
end
