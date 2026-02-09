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

ActiveRecord::Schema.define(version: 2025_12_09_231649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balance_books", force: :cascade do |t|
    t.bigint "paid_from_user_id", null: false
    t.bigint "paid_to_user_id", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "entry_by"
    t.bigint "entry_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entry_by", "entry_by_id"], name: "index_balance_books_on_entry_by_and_entry_by_id"
    t.index ["entry_by"], name: "index_balance_books_on_entry_by"
    t.index ["entry_by_id"], name: "index_balance_books_on_entry_by_id"
    t.index ["paid_from_user_id", "paid_to_user_id"], name: "index_balance_books_on_from_to"
    t.index ["paid_from_user_id", "paid_to_user_id"], name: "index_balance_books_on_paid_from_user_id_and_paid_to_user_id"
    t.index ["paid_from_user_id"], name: "index_balance_books_on_paid_from_user_id"
    t.index ["paid_to_user_id"], name: "index_balance_books_on_paid_to_user_id"
  end

  create_table "expense_items", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.string "name_of_item_in_expense", null: false
    t.decimal "amount_of_item", precision: 10, scale: 2, default: "0.0"
    t.bigint "assigned_to_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assigned_to_user_id"], name: "index_expense_items_on_assigned_to_user_id"
    t.index ["expense_id"], name: "index_expense_items_on_expense_id"
  end

  create_table "expense_participations", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "user_id", null: false
    t.decimal "share_amount_of_user", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_id", "user_id"], name: "index_expense_participations_on_expense_id_and_user_id", unique: true
    t.index ["expense_id"], name: "index_expense_participations_on_expense_id"
    t.index ["user_id"], name: "index_expense_participations_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "created_by_id", null: false
    t.string "expense_name", null: false
    t.decimal "tax_on_expense", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "total_amount_of_expense", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_expenses_on_created_by_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "payment_by_id", null: false
    t.bigint "payment_to_id", null: false
    t.decimal "amount_paid", precision: 10, scale: 2, default: "0.0", null: false
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_by_id", "payment_to_id"], name: "index_payments_on_payment_by_id_and_payment_to_id"
    t.index ["payment_by_id"], name: "index_payments_on_payment_by_id"
    t.index ["payment_to_id"], name: "index_payments_on_payment_to_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "mobile_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "balance_books", "users", column: "paid_from_user_id"
  add_foreign_key "balance_books", "users", column: "paid_to_user_id"
  add_foreign_key "expense_items", "expenses"
  add_foreign_key "expense_items", "users", column: "assigned_to_user_id"
  add_foreign_key "expense_participations", "expenses"
  add_foreign_key "expense_participations", "users"
  add_foreign_key "expenses", "users", column: "created_by_id"
  add_foreign_key "payments", "users", column: "payment_by_id"
  add_foreign_key "payments", "users", column: "payment_to_id"
end
