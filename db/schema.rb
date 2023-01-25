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

ActiveRecord::Schema[7.0].define(version: 2023_01_25_102212) do
  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "release_tracks", force: :cascade do |t|
    t.integer "release_id", null: false
    t.integer "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["release_id"], name: "index_release_tracks_on_release_id"
    t.index ["track_id"], name: "index_release_tracks_on_track_id"
  end

  create_table "releases", force: :cascade do |t|
    t.string "title"
    t.string "upc"
    t.integer "year"
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_releases_on_artist_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "product_type", null: false
    t.integer "product_id", null: false
    t.integer "artist_id", null: false
    t.string "transaction_type"
    t.float "net_share"
    t.float "label_share"
    t.float "artist_share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_sales_on_artist_id"
    t.index ["product_type", "product_id"], name: "index_sales_on_product"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "title"
    t.string "isrc"
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
  end

end
