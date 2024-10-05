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

ActiveRecord::Schema[7.2].define(version: 2024_10_03_105040) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completions", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.bigint "user_id", null: false
    t.date "completed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_completions_on_habit_id"
    t.index ["user_id"], name: "index_completions_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.date "target_date", null: false
    t.integer "target_frequency", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "target_volume_hours"
    t.integer "target_volume_minutes"
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_plans", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.integer "week", null: false
    t.integer "frequency", null: false
    t.integer "volume", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_weekly_plans_on_habit_id"
  end

  add_foreign_key "completions", "habits"
  add_foreign_key "completions", "users"
  add_foreign_key "habits", "users"
  add_foreign_key "weekly_plans", "habits"
end
