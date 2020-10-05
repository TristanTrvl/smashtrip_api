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

ActiveRecord::Schema.define(version: 2020_10_05_115328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conveniences", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "address"
    t.integer "nb_slots", null: false
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

  create_table "housing_adverts", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "event_id", null: false
    t.integer "price"
    t.text "desc"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_housing_adverts_on_user_id"
  end

  create_table "housing_reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "housing_advert_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "nb_persons", default: 1, null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["housing_advert_id"], name: "index_housing_reservations_on_housing_advert_id"
    t.index ["user_id"], name: "index_housing_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
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
  add_foreign_key "housing_adverts", "users"
  add_foreign_key "housing_reservations", "housing_adverts"
  add_foreign_key "housing_reservations", "users"
end
