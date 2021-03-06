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

ActiveRecord::Schema.define(version: 20140220123716) do

  create_table "sentences", force: true do |t|
    t.string   "sentence",   limit: 72, null: false
    t.string   "hashtag",    limit: 72, null: false
    t.datetime "last_twittered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", force: true do |t|
    t.string   "word",              limit: 16, null: false
    t.string   "description",       limit: 32, null: false
    t.string   "example",           limit: 64
    t.string   "translate",         limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_twittered_at"
  end

end
