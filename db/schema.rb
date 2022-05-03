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

ActiveRecord::Schema[7.0].define(version: 2022_05_03_072806) do
  create_table "daily_elapsed_times", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "todo", null: false
    t.date "target_date", null: false
    t.integer "elapsed_seconds", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_date"], name: "index_daily_elapsed_times_on_target_date"
    t.index ["uuid", "target_date"], name: "index_daily_elapsed_times_on_uuid_and_target_date", unique: true
  end

end
