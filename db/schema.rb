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

ActiveRecord::Schema.define(version: 2021_12_16_194661) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gist"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  connection.execute "CREATE SCHEMA IF NOT EXISTS public"
  connection.execute "CREATE SCHEMA IF NOT EXISTS  core"

  connection.schema_search_path = "public, core"

  create_table "core.accesses", force: :cascade do |t|
    t.string "access_token"
    t.string "renew_token"
    t.integer "token_type"
    t.datetime "expires_at"
    t.boolean "active", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_core.accesses_on_user_id"
  end

  create_table "core.active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_core.active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "core.active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_core.active_storage_blobs_on_key", unique: true
  end

  create_table "core.active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "core.groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "type", limit: 255, default: "Core::Team"
    t.jsonb "meta_data", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meta_data"], name: "index_core.groups_on_meta_data", using: :gin
    t.index ["name"], name: "index_core.groups_on_name", opclass: :gist_trgm_ops, using: :gist
    t.index ["type"], name: "index_core.groups_on_type"
  end

  create_table "core.guests", force: :cascade do |t|
    t.jsonb "meta_data", default: {}, null: false
    t.jsonb "identity", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "core.messages", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "sender_type", null: false
    t.bigint "sender_id", null: false
    t.jsonb "meta_data", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_type", "recipient_id"], name: "index_core.messages_on_recipient"
    t.index ["sender_type", "sender_id"], name: "index_core.messages_on_sender"
  end

  create_table "core.organizations", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "core.simple_auths", force: :cascade do |t|
    t.string "password_digest"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_core.simple_auths_on_user_id"
  end

  create_table "core.user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "roleable_type", null: false
    t.bigint "roleable_id", null: false
    t.string "logical_name", limit: 255
    t.integer "role_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["roleable_type", "roleable_id"], name: "index_core.user_roles_on_roleable"
    t.index ["user_id"], name: "index_core.user_roles_on_user_id"
  end

  create_table "core.users", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "core.accesses", "users"
  add_foreign_key "core.active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "core.active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "core.simple_auths", "users"
  add_foreign_key "core.user_roles", "users"
end
