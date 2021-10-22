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

ActiveRecord::Schema.define(version: 2021_10_21_221758) do

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "freelancers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_freelancers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_freelancers_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "freelancer_id", null: false
    t.index ["freelancer_id"], name: "index_profiles_on_freelancer_id"
  end

  create_table "project_abilities", force: :cascade do |t|
    t.integer "ability_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ability_id"], name: "index_project_abilities_on_ability_id"
    t.index ["project_id"], name: "index_project_abilities_on_project_id"
  end

  create_table "project_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_project_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_project_owners_on_reset_password_token", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "max_value"
    t.date "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_owner_id", null: false
    t.integer "location"
    t.integer "project_application", default: 5
    t.integer "project_status", default: 5
    t.index ["project_owner_id"], name: "index_projects_on_project_owner_id"
  end

  create_table "proposal_cancelations", force: :cascade do |t|
    t.text "reason"
    t.integer "proposal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_proposal_cancelations_on_proposal_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.text "application_reason"
    t.decimal "hour_value"
    t.integer "hours"
    t.date "deadline_proposal"
    t.integer "project_id", null: false
    t.integer "freelancer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 5
    t.index ["freelancer_id"], name: "index_proposals_on_freelancer_id"
    t.index ["project_id"], name: "index_proposals_on_project_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "profiles", "freelancers"
  add_foreign_key "project_abilities", "abilities"
  add_foreign_key "project_abilities", "projects"
  add_foreign_key "projects", "project_owners"
  add_foreign_key "proposal_cancelations", "proposals"
  add_foreign_key "proposals", "freelancers"
  add_foreign_key "proposals", "projects"
end
