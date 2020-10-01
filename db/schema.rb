# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_01_100921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conveniences", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "address"
    t.integer "nb_slots"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "houses_has_conveniences", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.bigint "convenience_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["convenience_id"], name: "index_houses_has_conveniences_on_convenience_id"
    t.index ["house_id"], name: "index_houses_has_conveniences_on_house_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.string "firstname"
    t.string "name"
    t.string "tel"
    t.string "twitter"
    t.string "discord"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "houses", "users"
  add_foreign_key "houses_has_conveniences", "conveniences"
  add_foreign_key "houses_has_conveniences", "houses"
end
