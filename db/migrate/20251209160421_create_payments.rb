class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :payment_by, null: false, foreign_key: { to_table: :users }
      t.references :payment_to, null: false, foreign_key: { to_table: :users }
      t.decimal :amount_paid, precision: 10, scale: 2, null: false, default: 0.0
      t.string :note

      t.timestamps
    end

    add_index :payments, [:payment_by_id, :payment_to_id]
  end
end
