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

ActiveRecord::Schema.define(version: 20171017074558) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "categories_id"
    t.bigint "documents_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_category_documents_on_categories_id"
    t.index ["documents_id"], name: "index_category_documents_on_documents_id"
  end

  create_table "coins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "number_coins"
    t.float "cost", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "users_id"
    t.bigint "documents_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documents_id"], name: "index_comments_on_documents_id"
    t.index ["users_id"], name: "index_comments_on_users_id"
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "number_download"
    t.string "url"
    t.integer "size"
    t.boolean "status"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_documents_on_users_id"
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "categories_id"
    t.bigint "documents_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_favorites_on_categories_id"
    t.index ["documents_id"], name: "index_favorites_on_documents_id"
  end

  create_table "friends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friends_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "users_id"
    t.bigint "documents_id"
    t.string "name_action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documents_id"], name: "index_histories_on_documents_id"
    t.index ["users_id"], name: "index_histories_on_users_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "users_id"
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
    t.index ["users_id"], name: "index_likes_on_users_id"
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "users_id"
    t.bigint "coins_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coins_id"], name: "index_payments_on_coins_id"
    t.index ["users_id"], name: "index_payments_on_users_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.datetime "birthday"
    t.string "address"
    t.string "phone"
    t.string "password_digest"
    t.integer "status"
    t.string "avatar"
    t.integer "role"
    t.integer "total_icon"
    t.integer "number_free"
    t.integer "number_upload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "category_documents", "categories", column: "categories_id"
  add_foreign_key "category_documents", "documents", column: "documents_id"
  add_foreign_key "comments", "documents", column: "documents_id"
  add_foreign_key "comments", "users", column: "users_id"
  add_foreign_key "documents", "users", column: "users_id"
  add_foreign_key "favorites", "categories", column: "categories_id"
  add_foreign_key "favorites", "documents", column: "documents_id"
  add_foreign_key "histories", "documents", column: "documents_id"
  add_foreign_key "histories", "users", column: "users_id"
  add_foreign_key "likes", "users", column: "users_id"
  add_foreign_key "payments", "coins", column: "coins_id"
  add_foreign_key "payments", "users", column: "users_id"
end
