class FriendsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend = User.find(params[:id])
    @user   = current_user
    @balance = @user.balances_with_all_users.find { |b| b[:friend].id == @friend.id }

    @shared_expenses = Expense
      .left_joins(:expense_items, :expense_participations)
      .where(
        "expenses.created_by_id IN (?) OR expense_participations.user_id IN (?) OR expense_items.assigned_to_user_id IN (?)",
        [@user.id, @friend.id], [@user.id, @friend.id], [@user.id, @friend.id]
      )
      .distinct
      .includes(:created_by)
      .order(created_at: :desc)
  end
end
