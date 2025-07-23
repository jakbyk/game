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

ActiveRecord::Schema[7.2].define(version: 2025_07_23_075101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "budget_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "start_budget", default: 0
  end

  create_table "change_proposals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "event_id"
    t.text "content"
    t.string "status", default: "created", null: false
    t.string "title"
    t.text "description"
    t.string "region"
    t.string "budget_name"
    t.bigint "budget_change", default: 0
    t.boolean "is_adding_to_budget"
    t.bigint "budget_reserve_change", default: 0
    t.boolean "need_increase_budget_reserve"
    t.text "positive_description"
    t.text "negative_description"
    t.integer "frequency", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_change_proposals_on_event_id"
    t.index ["user_id"], name: "index_change_proposals_on_user_id"
  end

  create_table "chats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "play_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_id"], name: "index_chats_on_play_id"
    t.index ["play_id"], name: "index_chats_on_play_id_null_unique", unique: true, where: "(play_id IS NULL)"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "region"
    t.string "budget_name"
    t.bigint "budget_change", default: 0
    t.boolean "is_adding_to_budget"
    t.bigint "budget_reserve_change", default: 0
    t.boolean "need_increase_budget_reserve"
    t.text "positive_description"
    t.text "negative_description"
    t.integer "frequency", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "sender_id"
    t.uuid "receiver_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_friendships_on_receiver_id"
    t.index ["sender_id"], name: "index_friendships_on_sender_id"
  end

  create_table "game_budget_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "current_value"
    t.bigint "expected_value"
    t.integer "positive_combo", default: 0
    t.integer "negative_combo", default: 0
    t.uuid "play_id", null: false
    t.index ["play_id", "name"], name: "index_game_budget_categories_on_play_id_and_name", unique: true
    t.index ["play_id"], name: "index_game_budget_categories_on_play_id"
  end

  create_table "game_budget_change_votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "game_budget_change_id", null: false
    t.boolean "vote", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_budget_change_id"], name: "index_game_budget_change_votes_on_game_budget_change_id"
    t.index ["user_id", "game_budget_change_id"], name: "index_votes_on_user_and_change", unique: true
    t.index ["user_id"], name: "index_game_budget_change_votes_on_user_id"
  end

  create_table "game_budget_changes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "value"
    t.boolean "is_adding"
    t.uuid "play_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_votable", default: true
    t.index ["play_id"], name: "index_game_budget_changes_on_play_id"
    t.index ["user_id"], name: "index_game_budget_changes_on_user_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.uuid "user_id", null: false
    t.uuid "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "play_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "play_id", null: false
    t.uuid "event_id", null: false
    t.integer "month", null: false
    t.string "outcome"
    t.datetime "resolved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_play_events_on_event_id"
    t.index ["play_id"], name: "index_play_events_on_play_id"
  end

  create_table "play_invitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "invitor_id", null: false
    t.uuid "play_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitor_id"], name: "index_play_invitations_on_invitor_id"
    t.index ["play_id"], name: "index_play_invitations_on_play_id"
    t.index ["user_id"], name: "index_play_invitations_on_user_id"
  end

  create_table "play_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "play_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_leader", default: false
    t.index ["play_id"], name: "index_play_users_on_play_id"
    t.index ["user_id"], name: "index_play_users_on_user_id"
  end

  create_table "plays", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.uuid "archived_by_id"
    t.float "social_satisfaction", default: 60.0
    t.integer "current_month", default: 0
    t.datetime "finished_at"
    t.bigint "budget_reserve"
    t.index ["archived_by_id"], name: "index_plays_on_archived_by_id"
  end

  create_table "settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "information_on_the_processing_of_personal_data"
    t.text "regulations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "defeat_description"
    t.text "subjected_description"
    t.jsonb "social_satisfaction_levels", default: []
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.string "first_name"
    t.string "last_name"
    t.datetime "time_of_acceptance_of_information_on_the_processing_of_personal", precision: nil
    t.datetime "time_of_acceptance_of_the_regulations", precision: nil
    t.boolean "is_tester", default: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "change_proposals", "users"
  add_foreign_key "chats", "plays"
  add_foreign_key "friendships", "users", column: "receiver_id"
  add_foreign_key "friendships", "users", column: "sender_id"
  add_foreign_key "game_budget_categories", "plays"
  add_foreign_key "game_budget_change_votes", "game_budget_changes"
  add_foreign_key "game_budget_change_votes", "users"
  add_foreign_key "game_budget_changes", "plays"
  add_foreign_key "game_budget_changes", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "play_events", "events"
  add_foreign_key "play_events", "plays"
  add_foreign_key "play_invitations", "plays"
  add_foreign_key "play_invitations", "users"
  add_foreign_key "play_invitations", "users", column: "invitor_id"
  add_foreign_key "play_users", "plays"
  add_foreign_key "play_users", "users"
  add_foreign_key "plays", "users", column: "archived_by_id"
end
