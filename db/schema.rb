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

ActiveRecord::Schema[7.0].define(version: 2022_11_09_100116) do
  create_table "carts", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "menu_id"
    t.bigint "count"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", charset: "utf8", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "menu_name"
    t.string "menu_description"
    t.integer "menu_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "menu_category"
    t.string "menu_image"
  end

  create_table "orders", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "menu"
    t.string "status"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mobile_no"
    t.string "password_digest"
    t.string "address"
    t.string "email"
  end

  create_table "workers", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.bigint "mobile_no"
  end

end
