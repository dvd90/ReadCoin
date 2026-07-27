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

ActiveRecord::Schema[8.1].define(version: 2026_07_27_155512) do
  create_table "books", force: :cascade do |t|
    t.string "author"
    t.string "cover_url"
    t.datetime "created_at", null: false
    t.string "genre"
    t.integer "max_age"
    t.integer "min_age"
    t.integer "reward"
    t.string "source_url"
    t.text "summary"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "kids", force: :cascade do |t|
    t.integer "age"
    t.string "avatar"
    t.integer "coins", default: 0, null: false
    t.datetime "created_at", null: false
    t.date "last_read_on"
    t.string "name"
    t.integer "parent_id", null: false
    t.string "pin_digest"
    t.integer "streak", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_kids_on_parent_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.json "questions"
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_quizzes_on_book_id"
  end

  create_table "readings", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "coins_earned"
    t.datetime "created_at", null: false
    t.integer "kid_id", null: false
    t.integer "quiz_score"
    t.string "status", default: "reading", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_readings_on_book_id"
    t.index ["kid_id"], name: "index_readings_on_kid_id"
  end

  create_table "redemptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "kid_id", null: false
    t.integer "reward_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["kid_id"], name: "index_redemptions_on_kid_id"
    t.index ["reward_id"], name: "index_redemptions_on_reward_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.integer "cost"
    t.datetime "created_at", null: false
    t.string "emoji"
    t.integer "parent_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_rewards_on_parent_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "kids", "users", column: "parent_id"
  add_foreign_key "quizzes", "books"
  add_foreign_key "readings", "books"
  add_foreign_key "readings", "kids"
  add_foreign_key "redemptions", "kids"
  add_foreign_key "redemptions", "rewards"
  add_foreign_key "rewards", "users", column: "parent_id"
  add_foreign_key "sessions", "users"
end
