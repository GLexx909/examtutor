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

ActiveRecord::Schema.define(version: 2019_04_06_054833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "body", null: false
    t.boolean "full_accordance", default: false
    t.integer "points", null: false
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "course_passages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_passages_on_course_id"
    t.index ["user_id"], name: "index_course_passages_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "essay_passages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "essay_id"
    t.string "body", null: false
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["essay_id"], name: "index_essay_passages_on_essay_id"
    t.index ["user_id"], name: "index_essay_passages_on_user_id"
  end

  create_table "essays", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "modul_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modul_id"], name: "index_essays_on_modul_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "abonent_id"
    t.string "body"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abonent_id"], name: "index_messages_on_abonent_id"
    t.index ["author_id"], name: "index_messages_on_author_id"
  end

  create_table "modul_passages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "modul_id"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modul_id"], name: "index_modul_passages_on_modul_id"
    t.index ["user_id"], name: "index_modul_passages_on_user_id"
  end

  create_table "moduls", force: :cascade do |t|
    t.integer "position"
    t.string "title"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_moduls_on_course_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.bigint "abonent_id"
    t.string "link"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abonent_id"], name: "index_notifications_on_abonent_id"
  end

  create_table "one_time_passwords", force: :cascade do |t|
    t.string "pass_word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.boolean "for_guests", default: false
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
  end

  create_table "question_passages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.string "answer"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_passages_on_question_id"
    t.index ["user_id"], name: "index_question_passages_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "questionable_type"
    t.bigint "questionable_id"
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable_type_and_questionable_id"
  end

  create_table "test_passages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "test_id"
    t.integer "points", default: 0
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_test_passages_on_test_id"
    t.index ["user_id"], name: "index_test_passages_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "modul_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modul_id"], name: "index_tests_on_modul_id"
  end

  create_table "topic_passages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_topic_passages_on_topic_id"
    t.index ["user_id"], name: "index_topic_passages_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.integer "position"
    t.bigint "modul_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modul_id"], name: "index_topics_on_modul_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "essay_passages", "essays"
  add_foreign_key "essay_passages", "users"
  add_foreign_key "messages", "users", column: "abonent_id"
  add_foreign_key "messages", "users", column: "author_id"
  add_foreign_key "modul_passages", "moduls"
  add_foreign_key "modul_passages", "users"
  add_foreign_key "notifications", "users", column: "abonent_id"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "question_passages", "questions"
  add_foreign_key "question_passages", "users"
  add_foreign_key "test_passages", "tests"
  add_foreign_key "test_passages", "users"
  add_foreign_key "tests", "moduls"
  add_foreign_key "topic_passages", "topics"
  add_foreign_key "topic_passages", "users"
  add_foreign_key "topics", "moduls"
end
