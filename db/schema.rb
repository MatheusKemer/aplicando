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

ActiveRecord::Schema.define(version: 20170425144323) do

  create_table "answers", force: :cascade do |t|
    t.string   "resposta"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dislikes", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.integer  "teacher_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_dislikes_on_question_id"
    t.index ["teacher_id"], name: "index_dislikes_on_teacher_id"
  end

  create_table "dones", force: :cascade do |t|
    t.integer  "student_id",  null: false
    t.integer  "exam_id",     null: false
    t.text     "respostas"
    t.datetime "finished_at", null: false
    t.float    "nota"
    t.index ["exam_id"], name: "index_dones_on_exam_id"
    t.index ["student_id"], name: "index_dones_on_student_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string   "title"
    t.integer  "turma_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_exams_on_teacher_id"
    t.index ["turma_id"], name: "index_exams_on_turma_id"
  end

  create_table "exams_questions", id: false, force: :cascade do |t|
    t.integer "exam_id",     null: false
    t.integer "question_id", null: false
  end

  create_table "exams_students", id: false, force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "exam_id",    null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.integer  "teacher_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_likes_on_question_id"
    t.index ["teacher_id"], name: "index_likes_on_teacher_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "pergunta"
    t.string   "correct"
    t.string   "answers"
    t.boolean  "visible",    default: true
    t.integer  "teacher_id"
    t.integer  "likes"
    t.integer  "dislikes"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["teacher_id"], name: "index_questions_on_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.text     "name"
    t.integer  "turma_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["turma_id"], name: "index_students_on_turma_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.text     "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turmas", force: :cascade do |t|
    t.integer  "ano"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_turmas_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
