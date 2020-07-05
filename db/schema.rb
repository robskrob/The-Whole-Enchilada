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

ActiveRecord::Schema.define(version: 2020_06_27_225504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.boolean "text_processed", default: false
    t.bigint "attachable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "alt_text"
    t.string "attachable_type"
    t.index ["attachable_id"], name: "index_images_on_attachable_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "recipe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position", default: 0
    t.boolean "deleted", default: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "parsed_lines", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "recipe_id"
    t.bigint "image_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false
    t.index ["image_id"], name: "index_parsed_lines_on_image_id"
    t.index ["recipe_id"], name: "index_parsed_lines_on_recipe_id"
  end

  create_table "parsed_long_lines", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "recipe_id"
    t.bigint "image_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false
    t.index ["image_id"], name: "index_parsed_long_lines_on_image_id"
    t.index ["recipe_id"], name: "index_parsed_long_lines_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "web_recipe_id"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
    t.index ["web_recipe_id"], name: "index_recipes_on_web_recipe_id"
  end

  create_table "steps", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "recipe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position", null: false
    t.string "title"
    t.boolean "deleted", default: false
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  create_table "tips", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "recipe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false
    t.index ["recipe_id"], name: "index_tips_on_recipe_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "recipe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position", default: 0
    t.boolean "deleted", default: false
    t.index ["recipe_id"], name: "index_tools_on_recipe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "web_recipes", force: :cascade do |t|
    t.string "name", null: false
    t.string "pathname", null: false
    t.text "content"
    t.text "host_origin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "images", "recipes", column: "attachable_id"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "parsed_lines", "images"
  add_foreign_key "parsed_lines", "recipes"
  add_foreign_key "parsed_long_lines", "images"
  add_foreign_key "parsed_long_lines", "recipes"
  add_foreign_key "recipes", "users"
  add_foreign_key "recipes", "web_recipes"
  add_foreign_key "steps", "recipes"
  add_foreign_key "tips", "recipes"
  add_foreign_key "tools", "recipes"
end
