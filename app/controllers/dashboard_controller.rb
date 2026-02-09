class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @total_due_to_you = @user.total_due_to_you
    @total_you_owe   = @user.total_you_owe
    @net_balance     = @user.net_balance
    @balances        = @user.balances_with_all_users
  end
end
