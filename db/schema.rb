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

ActiveRecord::Schema.define(version: 20171026015945) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "category_id"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_documents_on_category_id"
    t.index ["document_id"], name: "index_category_documents_on_document_id"
  end

  create_table "coins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "number_coins"
    t.float "cost", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "document_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_comments_on_document_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "number_download"
    t.string "file"
    t.integer "size"
    t.boolean "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "description"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_favorites_on_document_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "friends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friends_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "document_id"
    t.string "name_action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_histories_on_document_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "coin_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_payments_on_coin_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.datetime "birthday"
    t.string "address"
    t.string "phone"
    t.string "password_digest"
    t.boolean "status", default: false
    t.string "avatar"
    t.boolean "role", default: true
    t.integer "total_coin", default: 0
    t.integer "number_free", default: 3
    t.integer "number_upload", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "category_documents", "categories"
  add_foreign_key "category_documents", "documents"
  add_foreign_key "comments", "documents"
  add_foreign_key "comments", "users"
  add_foreign_key "documents", "users"
  add_foreign_key "favorites", "documents"
  add_foreign_key "favorites", "users"
  add_foreign_key "histories", "documents"
  add_foreign_key "histories", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "payments", "coins"
  add_foreign_key "payments", "users"
end
