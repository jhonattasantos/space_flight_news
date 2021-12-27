# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_27_154820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.boolean "featured"
    t.string "origin_id"
    t.string "title"
    t.string "url"
    t.string "imageUrl"
    t.string "newsSite"
    t.string "summary"
    t.string "publishedAt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "articles_events", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_articles_events_on_article_id"
    t.index ["event_id"], name: "index_articles_events_on_event_id"
  end

  create_table "articles_launches", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "launch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_articles_launches_on_article_id"
    t.index ["launch_id"], name: "index_articles_launches_on_launch_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "origin_id"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "launches", force: :cascade do |t|
    t.string "origin_id"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "articles_events", "articles"
  add_foreign_key "articles_events", "events"
  add_foreign_key "articles_launches", "articles"
  add_foreign_key "articles_launches", "launches"
end
