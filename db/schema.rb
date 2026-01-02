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

ActiveRecord::Schema[8.1].define(version: 2026_01_02_045042) do
  create_table "books", force: :cascade do |t|
    t.string "author"
    t.string "cover_image_url"
    t.datetime "created_at", null: false
    t.integer "current_page", default: 0
    t.datetime "finished_at"
    t.string "isbn"
    t.integer "rating"
    t.text "review_text"
    t.datetime "started_at"
    t.string "status", default: "want_to_read"
    t.string "title"
    t.integer "total_pages"
    t.datetime "updated_at", null: false
  end

  create_table "reading_sessions", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.integer "pages_read"
    t.datetime "start_time"
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reading_sessions_on_book_id"
  end

  add_foreign_key "reading_sessions", "books"
end
