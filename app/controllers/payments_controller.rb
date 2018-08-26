class PaymentsController < ApplicationController
  before_action :set_order

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @order.amount_cents,
      description:  "Payment of #{@order.amount} in RDC for order #{@order.id}",
      currency:     @order.amount.currency
    )

    @order.update(payment: charge.to_json, state: 'paid')
    @user = current_user
    @user.wallet += @order.amount
    @user.save!
    redirect_to order_path(@order)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)

    raise


  end

private

  def set_order
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end
end
