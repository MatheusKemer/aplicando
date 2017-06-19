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

ActiveRecord::Schema.define(version: 20170611222007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string   "resposta"
    t.integer  "question_id"
    t.datetime "created_at",  precision: 6, null: false
    t.datetime "updated_at",  precision: 6, null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.integer  "school_class_id"
    t.datetime "created_at",      precision: 6, null: false
    t.datetime "updated_at",      precision: 6, null: false
    t.text     "students",                                   array: true
  end

  create_table "dislikes", force: :cascade do |t|
    t.integer  "question_id",               null: false
    t.integer  "teacher_id",                null: false
    t.datetime "created_at",  precision: 6, null: false
    t.datetime "updated_at",  precision: 6, null: false
  end

  create_table "dones", force: :cascade do |t|
    t.integer  "student_id",                null: false
    t.integer  "exam_id",                   null: false
    t.text     "respostas"
    t.datetime "finished_at", precision: 6, null: false
    t.float    "nota"
  end

  create_table "exams", force: :cascade do |t|
    t.string   "title"
    t.integer  "discipline_id"
    t.integer  "teacher_id"
    t.datetime "created_at",    precision: 6, null: false
    t.datetime "updated_at",    precision: 6, null: false
  end

  create_table "exams_questions", id: false, force: :cascade do |t|
    t.integer "exam_id",     null: false
    t.integer "question_id", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "question_id",               null: false
    t.integer  "teacher_id",                null: false
    t.datetime "created_at",  precision: 6, null: false
    t.datetime "updated_at",  precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "pergunta"
    t.string   "correct"
    t.string   "answers"
    t.boolean  "visible",                     default: true
    t.integer  "teacher_id"
    t.integer  "discipline_id"
    t.integer  "likes"
    t.integer  "dislikes"
    t.datetime "created_at",    precision: 6,                null: false
    t.datetime "updated_at",    precision: 6,                null: false
  end

  create_table "school_classes", force: :cascade do |t|
    t.integer  "ano"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.text     "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             precision: 6,              null: false
    t.datetime "updated_at",             precision: 6,              null: false
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at",    precision: 6
    t.integer  "sign_in_count",                        default: 0,  null: false
    t.datetime "current_sign_in_at",     precision: 6
    t.datetime "last_sign_in_at",        precision: 6
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "type"
    t.string   "locale"
  end

end
