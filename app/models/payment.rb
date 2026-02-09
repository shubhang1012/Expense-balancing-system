class Payment < ApplicationRecord
  belongs_to :payment_by, class_name: "User"
  belongs_to :payment_to, class_name: "User"

  validates :amount_paid, numericality: { greater_than: 0 }
  validate :different_users
  validates :note, length: { maximum: 255 }, allow_blank: true

  after_create :record_in_balance_book

  private

  def different_users
    if payment_by_id.present? && payment_by_id == payment_to_id
      errors.add(:payment_to_id, "cannot be the same as payer")
    end
  end

  def record_in_balance_book
    BalanceBook.create!(
      paid_from_user: payment_by,
      paid_to_user: payment_to,
      amount: -amount_paid.to_d, 
      entry_by: "Payment",
      entry_by_id: id
    )
  end
end
