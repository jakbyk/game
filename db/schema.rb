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

ActiveRecord::Schema[7.2].define(version: 2025_06_24_182446) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "start_budget", default: 0
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "play_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_id"], name: "index_chats_on_play_id"
    t.index ["play_id"], name: "index_chats_on_play_id_null_unique", unique: true, where: "(play_id IS NULL)"
  end

  create_table "game_budget_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "current_value"
    t.bigint "expected_value"
    t.integer "positive_combo", default: 0
    t.integer "negative_combo", default: 0
    t.bigint "play_id", null: false
    t.index ["play_id", "name"], name: "index_game_budget_categories_on_play_id_and_name", unique: true
    t.index ["play_id"], name: "index_game_budget_categories_on_play_id"
  end

  create_table "game_budget_change_votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_budget_change_id", null: false
    t.boolean "vote", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_budget_change_id"], name: "index_game_budget_change_votes_on_game_budget_change_id"
    t.index ["user_id", "game_budget_change_id"], name: "index_votes_on_user_and_change", unique: true
    t.index ["user_id"], name: "index_game_budget_change_votes_on_user_id"
  end

  create_table "game_budget_changes", force: :cascade do |t|
    t.string "name"
    t.bigint "value"
    t.boolean "is_adding"
    t.bigint "play_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_votable", default: true
    t.index ["play_id"], name: "index_game_budget_changes_on_play_id"
    t.index ["user_id"], name: "index_game_budget_changes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "play_users", force: :cascade do |t|
    t.bigint "play_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_leader", default: false
    t.index ["play_id"], name: "index_play_users_on_play_id"
    t.index ["user_id"], name: "index_play_users_on_user_id"
  end

  create_table "plays", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.bigint "archived_by_id"
    t.float "social_satisfaction", default: 60.0
    t.integer "current_month", default: 0
    t.datetime "finished_at"
    t.bigint "budget_reserve"
    t.index ["archived_by_id"], name: "index_plays_on_archived_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "last_seen_at"
    t.boolean "is_admin", default: false
  end

  add_foreign_key "chats", "plays"
  add_foreign_key "game_budget_categories", "plays"
  add_foreign_key "game_budget_change_votes", "game_budget_changes"
  add_foreign_key "game_budget_change_votes", "users"
  add_foreign_key "game_budget_changes", "plays"
  add_foreign_key "game_budget_changes", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "play_users", "plays"
  add_foreign_key "play_users", "users"
  add_foreign_key "plays", "users", column: "archived_by_id"
end
