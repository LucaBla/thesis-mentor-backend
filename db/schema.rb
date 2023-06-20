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

ActiveRecord::Schema[7.0].define(version: 2023_06_20_161812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_statuses", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supervisor_id"
    t.bigint "billing_status_id"
    t.bigint "status_id"
    t.bigint "theme_id"
    t.bigint "student_id"
    t.bigint "second_supervisor_id"
    t.index ["billing_status_id"], name: "index_chats_on_billing_status_id"
    t.index ["second_supervisor_id"], name: "index_chats_on_second_supervisor_id"
    t.index ["status_id"], name: "index_chats_on_status_id"
    t.index ["student_id"], name: "index_chats_on_student_id"
    t.index ["supervisor_id"], name: "index_chats_on_supervisor_id"
    t.index ["theme_id"], name: "index_chats_on_theme_id"
  end

  create_table "devise_api_tokens", force: :cascade do |t|
    t.string "resource_owner_type", null: false
    t.bigint "resource_owner_id", null: false
    t.string "access_token", null: false
    t.string "refresh_token"
    t.integer "expires_in", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_devise_api_tokens_on_access_token"
    t.index ["previous_refresh_token"], name: "index_devise_api_tokens_on_previous_refresh_token"
    t.index ["refresh_token"], name: "index_devise_api_tokens_on_refresh_token"
    t.index ["resource_owner_type", "resource_owner_id"], name: "index_devise_api_tokens_on_resource_owner"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chat_id"
    t.bigint "user_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supervisors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supervisors_tags", id: false, force: :cascade do |t|
    t.bigint "supervisor_id", null: false
    t.bigint "tag_id", null: false
    t.index ["supervisor_id", "tag_id"], name: "index_supervisors_tags_on_supervisor_id_and_tag_id"
    t.index ["tag_id", "supervisor_id"], name: "index_supervisors_tags_on_tag_id_and_supervisor_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_themes", id: false, force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "theme_id"
    t.index ["tag_id"], name: "index_tags_themes_on_tag_id"
    t.index ["theme_id"], name: "index_tags_themes_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supervisor_id"
    t.index ["supervisor_id"], name: "index_themes_on_supervisor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chats", "billing_statuses"
  add_foreign_key "chats", "statuses"
  add_foreign_key "chats", "themes"
  add_foreign_key "chats", "users", column: "second_supervisor_id"
  add_foreign_key "chats", "users", column: "student_id"
  add_foreign_key "chats", "users", column: "supervisor_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "themes", "users", column: "supervisor_id"
end
