# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140220133308) do

  create_table "docs", force: true do |t|
    t.string   "title",      limit: 100,              null: false
    t.text     "content",                             null: false
    t.string   "method",     limit: 10,  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "docs", ["slug"], name: "index_docs_on_slug"

  create_table "licenses", force: true do |t|
    t.string   "name",                   null: false
    t.text     "description",            null: false
    t.string   "url",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",        limit: 40
  end

  add_index "licenses", ["uuid"], name: "index_licenses_on_uuid"

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

  create_table "resource_types", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",       limit: 40
  end

  add_index "resource_types", ["uuid"], name: "index_resource_types_on_uuid"

  create_table "resources", force: true do |t|
    t.integer  "resource_type_id"
    t.integer  "license_id"
    t.integer  "user_id"
    t.string   "name",                                     null: false
    t.string   "url",                         default: "", null: false
    t.string   "description",                 default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",             limit: 40
  end

  add_index "resources", ["uuid"], name: "index_resources_on_uuid"

  create_table "resources_tags", id: false, force: true do |t|
    t.integer "resource_id"
    t.integer "tag_id"
  end

  add_index "resources_tags", ["resource_id", "tag_id"], name: "index_resources_tags_on_resource_id_and_tag_id"

  create_table "tags", force: true do |t|
    t.string   "tag",        limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",       limit: 40
  end

  add_index "tags", ["uuid"], name: "index_tags_on_uuid"

  create_table "users", force: true do |t|
    t.string   "email",           limit: 254,                 null: false
    t.string   "password_digest",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname",                   default: "",    null: false
    t.string   "lastname",                    default: "",    null: false
    t.boolean  "admin",                       default: false
    t.string   "uuid",            limit: 40
  end

  add_index "users", ["uuid"], name: "index_users_on_uuid"

end
