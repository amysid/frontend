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

ActiveRecord::Schema.define(version: 2022_02_02_180511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_files", force: :cascade do |t|
    t.string "book_cover"
    t.string "audio_file"
    t.string "short_audio"
    t.bigint "book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_book_files_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author_name"
    t.string "body"
    t.integer "book_duration", default: 0
    t.string "reason_for_rejection"
    t.integer "status", default: 0
    t.integer "listen_count", default: 0
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "books_categories", id: false, force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "category_id", null: false
    t.index ["book_id", "category_id"], name: "index_books_categories_on_book_id_and_category_id"
    t.index ["category_id", "book_id"], name: "index_books_categories_on_category_id_and_book_id"
  end

  create_table "booths", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.string "city"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "location"
    t.string "phone_number"
    t.integer "listening_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_booths_on_number"
  end

  create_table "booths_categories", id: false, force: :cascade do |t|
    t.bigint "booth_id", null: false
    t.bigint "category_id", null: false
    t.index ["booth_id", "category_id"], name: "index_booths_categories_on_booth_id_and_category_id"
    t.index ["category_id", "booth_id"], name: "index_booths_categories_on_category_id_and_booth_id"
  end

  create_table "booths_users", id: false, force: :cascade do |t|
    t.bigint "booth_id", null: false
    t.bigint "user_id", null: false
    t.index ["booth_id", "user_id"], name: "index_booths_users_on_booth_id_and_user_id"
    t.index ["user_id", "booth_id"], name: "index_booths_users_on_user_id_and_booth_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "operations", force: :cascade do |t|
    t.integer "number"
    t.string "listening_status"
    t.datetime "listening_time"
    t.string "rating"
    t.string "note"
    t.bigint "book_id"
    t.bigint "booth_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_operations_on_book_id"
    t.index ["booth_id"], name: "index_operations_on_booth_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", default: ""
    t.string "mobile", default: ""
    t.string "email", default: ""
    t.integer "gender", default: 0
    t.integer "role"
    t.integer "status", default: 0
    t.string "password_digest", default: ""
    t.string "verificatin_link", default: ""
    t.datetime "last_login_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
