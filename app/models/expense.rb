class Expense < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  has_many :expense_items, dependent: :destroy
  has_many :expense_participations, dependent: :destroy
  has_many :participants, through: :expense_participations, source: :user

  accepts_nested_attributes_for :expense_items, allow_destroy: true
  accepts_nested_attributes_for :expense_participations, allow_destroy: true

  validates :expense_name, presence: true
  validates :tax_on_expense, :total_amount_of_expense, numericality: { greater_than_or_equal_to: 0 }

  # === COMPUTATIONS ===

  # Update total based on items + tax
  def compute_total!
    subtotal = expense_items.sum(:amount_of_item).to_d
    update!(total_amount_of_expense: subtotal + tax_on_expense.to_d)
  end

  # Equal split fallback (for display only)
  def share_per_person
    return 0.to_d if participants.blank?
    (total_amount_of_expense.to_d / participants.size).round(2)
  end

  # === SHARE LOGIC ===
  # Calculate share per user only for selected participants
  def per_user_shares
    ids = expense_participations.pluck(:user_id)
    return {} if ids.blank?

    shares = Hash.new(0.to_d)
    unassigned_total = 0.to_d

    # 1️⃣ Assigned items
    expense_items.each do |item|
      amt = item.amount_of_item.to_d
      if item.assigned_to_user_id.present? && ids.include?(item.assigned_to_user_id)
        shares[item.assigned_to_user_id] += amt
      else
        unassigned_total += amt
      end
    end

    # 2️⃣ Split unassigned equally
    shares = distribute_equally(shares, ids, unassigned_total) if unassigned_total.positive?

    # 3️⃣ Split tax equally
    tax_amt = tax_on_expense.to_d
    shares = distribute_equally(shares, ids, tax_amt) if tax_amt.positive?

    normalize_shares(shares)
  end

  # Save shares into expense_participations
  def recompute_participation_shares!
    computed = per_user_shares
    expense_participations.includes(:user).each do |ep|
      ep.update!(share_amount_of_user: computed[ep.user_id] || 0)
    end
  end

  # === LEDGER UPDATES ===
  # Add only relevant entries to BalanceBook
  def post_to_ledger!
    computed = per_user_shares
    participants.each do |p|
      next if p.id == created_by_id
      next unless computed.key?(p.id)

      share = computed[p.id].to_d
      next if share <= 0

      BalanceBook.create!(
        paid_from_user: p,
        paid_to_user: created_by,
        amount: share,
        entry_by: "Expense",
        entry_by_id: id
      )
    end
  end

  private

  # Split a total equally among participant IDs
  def distribute_equally(shares, ids, amount)
    n = ids.size
    return shares if n.zero? || amount <= 0

    base = (amount / n).floor(2)
    remainder = (amount - (base * n)).round(2)
    ids.each_with_index do |uid, idx|
      shares[uid] += base + (idx.zero? ? remainder : 0)
    end
    shares
  end

  # Ensure all totals sum to exact total
  def normalize_shares(shares)
    rounded = shares.transform_values { |v| v.round(2) }
    diff = total_amount_of_expense.to_d - rounded.values.sum
    if diff.nonzero? && (uid = rounded.keys.first)
      rounded[uid] = (rounded[uid] + diff).round(2)
    end
    rounded
  end
end
