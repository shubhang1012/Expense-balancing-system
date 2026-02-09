class BalanceBook < ApplicationRecord
  belongs_to :paid_from_user, class_name: "User"
  belongs_to :paid_to_user, class_name: "User"

  validates :amount, numericality: true
  validate :users_cannot_be_same

  scope :between, ->(user_a, user_b) do
    where(
      "(paid_from_user_id = :a AND paid_to_user_id = :b) OR (paid_from_user_id = :b AND paid_to_user_id = :a)",
      a: user_a.id, b: user_b.id
    )
  end

  def users_cannot_be_same
    if paid_from_user_id.present? && paid_from_user_id == paid_to_user_id
      errors.add(:paid_to_user_id, "must be different from paid_from_user")
    end
  end

  def self.net_balance_between(user_a, user_b)
    sql = sanitize_sql_array([
      "CASE WHEN paid_to_user_id = ? THEN amount ELSE -amount END",
      user_a.id
    ])
    between(user_a, user_b).sum(Arel.sql(sql)).to_d.round(2)
  end
end
