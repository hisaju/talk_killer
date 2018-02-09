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

ActiveRecord::Schema.define(version: 20180209074411) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "talk_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["talk_id"], name: "index_comments_on_talk_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "talk_id"
    t.integer  "comment_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["comment_id"], name: "index_replies_on_comment_id"
  add_index "replies", ["talk_id"], name: "index_replies_on_talk_id"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "summaries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "talk_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "summaries", ["talk_id"], name: "index_summaries_on_talk_id"
  add_index "summaries", ["user_id"], name: "index_summaries_on_user_id"

  create_table "talks", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "summary"
    t.string   "template"
    t.integer  "status"
    t.date     "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "status"
    t.date     "due_date"
    t.boolean  "event"
    t.boolean  "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.string   "uid",                    default: "",    null: false
    t.string   "provider",               default: "",    null: false
    t.string   "image_url"
    t.string   "avatar"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true

end
