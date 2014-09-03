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

ActiveRecord::Schema.define(version: 20140828004340) do

  create_table "add_name_to_clozequestions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "classnotes", force: true do |t|
    t.string   "name"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clozequestions", force: true do |t|
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "media"
  end

  create_table "fillquestions", force: true do |t|
    t.string   "name"
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media"
  end

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.string   "level"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vocabulary_content"
    t.string   "grammar_content"
    t.string   "phonics_content"
    t.string   "reading_content"
    t.string   "lyrics_content"
  end

  create_table "lessonvocas", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "vocabulary_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "matchquestion_id"
    t.string   "name"
    t.string   "question"
    t.string   "match"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio"
  end

  create_table "matchquestions", force: true do |t|
    t.string   "name"
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio"
  end

  create_table "multichoicequestions", force: true do |t|
    t.string   "name"
    t.string   "question"
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "choice_label_display_mode"
    t.string   "media"
    t.integer  "vocabulary_id"
    t.string   "question_type"
  end

  create_table "quizquestionresults", force: true do |t|
    t.integer  "quizquestion_id"
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizquestions", force: true do |t|
    t.integer  "quiz_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "origin_id"
    t.string   "qtype"
  end

  create_table "quizzes", force: true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "testid"
    t.string   "quiz_type"
  end

  create_table "userlessons", force: true do |t|
    t.string   "user_id"
    t.string   "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "level"
  end

  create_table "uservocas", force: true do |t|
    t.integer  "user_id"
    t.integer  "vocabulary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vocabularies", force: true do |t|
    t.string   "name"
    t.string   "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio"
    t.string   "image"
    t.string   "group"
    t.string   "supergroup"
  end

  create_table "vocadrills", force: true do |t|
    t.integer  "vocabulary_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
