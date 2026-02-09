class CreateExpenseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_items do |t|
      t.references :expense, null: false, foreign_key: true
      t.string :name_of_item_in_expense, null: false
      t.decimal :amount_of_item, precision: 10, scale: 2, default: 0.0
      t.references :assigned_to_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
