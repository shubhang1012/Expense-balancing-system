class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = current_user.expenses_created.includes(:expense_items)
  end

  def new
    @expense = current_user.expenses_created.new
    @expense.expense_items.build
  end

  def create
    @expense = current_user.expenses_created.build(expense_params)

    ActiveRecord::Base.transaction do
      @expense.compute_total! # calculate total before saving
      @expense.save!

      # Collect only selected participants + creator
      participant_ids = Array(params[:participant_ids]).map(&:to_i).uniq
      participant_ids << current_user.id
      participant_ids.uniq!

      # Ensure only those participants are stored
      @expense.expense_participations.destroy_all
      participant_ids.each do |uid|
        @expense.expense_participations.create!(user_id: uid, share_amount_of_user: 0)
      end

      # Recompute correct shares
      @expense.compute_total!
      @expense.recompute_participation_shares!

      # Post only to relevant participants in ledger
      @expense.post_to_ledger!
    end

    redirect_to @expense, notice: "Expense created successfully!"
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join(", ")
    render :new, status: :unprocessable_entity
  end

  def show
    @expense = Expense.find(params[:id])
    @expense_items = @expense.expense_items
    @participants = @expense.participants
  end

  private

  def expense_params
    params.require(:expense).permit(
      :expense_name,
      :tax_on_expense,
      :total_amount_of_expense,
      expense_items_attributes: [:name_of_item_in_expense, :amount_of_item, :assigned_to_user_id, :_destroy]
    )
  end
end
