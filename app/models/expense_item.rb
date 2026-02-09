class ExpenseItem < ApplicationRecord
  belongs_to :expense
  belongs_to :assigned_to_user, class_name: "User", optional: true

  validates :name_of_item_in_expense, presence: true
  validates :amount_of_item, numericality: { greater_than_or_equal_to: 0 }

  after_save :touch_expense_total
  after_destroy :touch_expense_total

  private

  def touch_expense_total
    subtotal = expense.expense_items.sum(:amount_of_item).to_d
    total = subtotal + expense.tax_on_expense.to_d
    expense.update_column(:total_amount_of_expense, total)
  end
end
