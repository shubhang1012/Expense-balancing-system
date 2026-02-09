class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses_created, class_name: "Expense", foreign_key: "created_by_id", dependent: :destroy
  has_many :expense_participations, dependent: :destroy
  has_many :payments_made, class_name: "Payment", foreign_key: "payment_by_id", dependent: :destroy
  has_many :payments_received, class_name: "Payment", foreign_key: "payment_to_id", dependent: :destroy

  def balances_with_all_users
    User.where.not(id: id).map do |friend|
      { friend: friend, net_balance: net_with(friend) }
    end
  end

  def total_due_to_you
    balances_with_all_users.sum { |b| [b[:net_balance], 0].max }.round(2)
  end

  def total_you_owe
    balances_with_all_users.sum { |b| [-b[:net_balance], 0].max }.round(2)
  end

  def net_balance
    (total_due_to_you - total_you_owe).round(2)
  end

  def net_with(friend)
    BalanceBook.net_balance_between(self, friend)
  end
end
