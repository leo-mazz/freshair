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

ActiveRecord::Schema.define(version: 20170617180552) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "location"
    t.datetime "start"
    t.datetime "end"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.text     "description"
    t.string   "location"
    t.string   "facebook_event"
    t.string   "link_to_tickets"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "issues", force: :cascade do |t|
    t.text     "description"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "solved"
  end

  create_table "pages", force: :cascade do |t|
    t.string  "title"
    t.text    "content"
    t.string  "slug"
    t.integer "priority"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "uri"
    t.integer  "show_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "broadcast_date"
    t.index ["show_id"], name: "index_podcasts_on_show_id"
  end

  create_table "post_metadata", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_metadata_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "short_body"
    t.text     "content"
    t.integer  "author_id"
    t.boolean  "is_published"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "slug"
    t.integer  "team_id"
    t.integer  "show_id"
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["show_id"], name: "index_posts_on_show_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["team_id"], name: "index_posts_on_team_id"
  end

  create_table "posts_tags", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.index ["post_id"], name: "index_posts_tags_on_post_id"
    t.index ["tag_id"], name: "index_posts_tags_on_tag_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "schedule_assignments", force: :cascade do |t|
    t.integer  "day_of_week"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "schedule_id"
    t.integer  "show_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_schedule_assignments_on_schedule_id"
    t.index ["show_id"], name: "index_schedule_assignments_on_show_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_current"
    t.date     "end_date"
    t.integer  "next_schedule_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["next_schedule_id"], name: "index_schedules_on_next_schedule_id"
  end

  create_table "show_memberships", force: :cascade do |t|
    t.integer "show_id"
    t.integer "user_id"
    t.index ["show_id"], name: "index_show_memberships_on_show_id"
    t.index ["user_id"], name: "index_show_memberships_on_user_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string   "title"
    t.string   "tag_line"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "pic"
  end

  create_table "sub_pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.integer  "priority"
    t.index ["page_id"], name: "index_sub_pages_on_page_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_post_type"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.boolean "is_manager"
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "display_order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "approved",               default: false, null: false
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
