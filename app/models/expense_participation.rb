class ExpenseParticipation < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  validates :share_amount_of_user, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
