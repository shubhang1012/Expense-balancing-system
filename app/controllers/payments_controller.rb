class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @payment = Payment.new(payment_to_id: params[:payment_to], amount_paid: params[:amount])
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.payment_by = current_user

    if @payment.save
      redirect_to friend_path(@payment.payment_to), notice: "Payment recorded successfully!"
    else
      flash.now[:alert] = @payment.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_to_id, :amount_paid, :note)
  end
end
