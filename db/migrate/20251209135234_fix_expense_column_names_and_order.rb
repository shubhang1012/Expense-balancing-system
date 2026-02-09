class FixExpenseColumnNamesAndOrder < ActiveRecord::Migration[6.1]
  def change
    # Rename existing columns
    rename_column :expenses, :description, :expense_name if column_exists?(:expenses, :description)
    rename_column :expenses, :tax, :tax_on_expense if column_exists?(:expenses, :tax)
    rename_column :expenses, :total, :total_amount_of_expense if column_exists?(:expenses, :total)

    # Ensure created_by_id is properly set up
    unless column_exists?(:expenses, :created_by_id)
      add_reference :expenses, :created_by, foreign_key: { to_table: :users }
    end
  end
end
