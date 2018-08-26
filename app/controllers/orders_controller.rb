class OrdersController < ApplicationController
  def show
    @order = current_user.orders.where(state: 'paid').find(params[:id])
  end
  def create
    @order  = Order.create!( amount: params[:amount], state: 'pending', user: current_user)

    redirect_to new_order_payment_path(@order)
  end
end
