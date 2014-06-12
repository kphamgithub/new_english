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

ActiveRecord::Schema.define(version: 20140608111047) do

  create_table "fillquestions", force: true do |t|
    t.string   "name"
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio"
    t.string   "image"
  end

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video"
    t.string   "content"
    t.integer  "level"
  end

  create_table "matches", force: true do |t|
    t.integer  "matchquestion_id"
    t.string   "name"
    t.string   "match_id"
    t.string   "left"
    t.string   "right"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matchquestions", force: true do |t|
    t.string   "name"
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multichoicequestions", force: true do |t|
    t.string   "name"
    t.string   "question"
    t.string   "audio"
    t.string   "video"
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
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
    t.string   "match_id"
  end

  create_table "quizzes", force: true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "testid"
  end

  create_table "users", force: true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "level"
  end

end
