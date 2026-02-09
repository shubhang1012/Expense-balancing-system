class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :description, null: false
      t.decimal :tax, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :total, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
