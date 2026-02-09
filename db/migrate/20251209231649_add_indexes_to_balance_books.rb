class AddIndexesToBalanceBooks < ActiveRecord::Migration[6.1]
  def change
    add_index :balance_books, [:paid_from_user_id, :paid_to_user_id], name: "index_balance_books_on_from_to"
    add_index :balance_books, :entry_by
    add_index :balance_books, :entry_by_id
  end
end
