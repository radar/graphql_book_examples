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

ActiveRecord::Schema[7.1].define(version: 2023_10_22_192458) do
  create_table "activities", force: :cascade do |t|
    t.integer "repo_id", null: false
    t.string "event_type", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type", "event_id"], name: "index_activities_on_event"
    t.index ["repo_id"], name: "index_activities_on_repo_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorized_repos", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "repo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categorized_repos_on_category_id"
    t.index ["repo_id"], name: "index_categorized_repos_on_repo_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "repo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_likes_on_repo_id"
  end

  create_table "repos", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "repo_id", null: false
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_reviews_on_repo_id"
  end

  add_foreign_key "activities", "repos"
  add_foreign_key "categorized_repos", "categories"
  add_foreign_key "categorized_repos", "repos"
  add_foreign_key "likes", "repos"
  add_foreign_key "reviews", "repos"
end
