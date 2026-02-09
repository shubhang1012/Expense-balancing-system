class CreateBalanceBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :balance_books do |t|
      t.references :paid_from_user, null: false, foreign_key: { to_table: :users }
      t.references :paid_to_user, null: false, foreign_key: { to_table: :users }
      t.decimal :amount, precision: 10, scale: 2, null: false, default: 0.0
      t.string :entry_by
      t.bigint :entry_by_id

      t.timestamps
    end

    add_index :balance_books, [:entry_by, :entry_by_id]
    add_index :balance_books, [:paid_from_user_id, :paid_to_user_id]
  end
end
