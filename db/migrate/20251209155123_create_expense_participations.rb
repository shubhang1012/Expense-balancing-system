class CreateExpenseParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_participations do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :share_amount_of_user, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end

    # Prevent a user from appearing twice for the same expense
    add_index :expense_participations, [:expense_id, :user_id], unique: true
  end
end
