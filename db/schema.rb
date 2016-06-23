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

ActiveRecord::Schema.define(version: 20160618132915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_authors", force: :cascade do |t|
    t.string   "authortype"
    t.integer  "author_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "article_authors", ["article_id"], name: "index_article_authors_on_article_id", using: :btree
  add_index "article_authors", ["author_id"], name: "index_article_authors_on_author_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "article_name"
    t.integer  "issue_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "pdf_path"
    t.string   "keywords",      default: [],              array: true
    t.string   "author_name",   default: [],              array: true
    t.string   "keywords_role", default: [],              array: true
  end

  add_index "articles", ["issue_id"], name: "index_articles_on_issue_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "author_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "number"
    t.string   "volume"
    t.integer  "year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "issues", ["year_id"], name: "index_issues_on_year_id", using: :btree

  create_table "journals", force: :cascade do |t|
    t.string   "journal_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "years", force: :cascade do |t|
    t.string   "journal_year"
    t.integer  "journal_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "years", ["journal_id"], name: "index_years_on_journal_id", using: :btree

  add_foreign_key "article_authors", "articles"
  add_foreign_key "article_authors", "authors"
  add_foreign_key "issues", "years"
  add_foreign_key "years", "journals"
end
