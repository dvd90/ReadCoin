class PurchasesController < ApplicationController

  def show
    @purchase = Purchase.find(params[:id])
    @kid = Kid.find(params[:kid_id])
  end

  def create
    @purchase = Purchase.new
    @kid = Kid.find(params[:kid_id])
    @prize = Prize.find(params[:prize_id])
    @kid.wallet -= @prize.price
    @kid.save!
    @purchase.kid = @kid
    @purchase.prize = @prize
    if @purchase.save!
      redirect_to kid_prize_purchase_path(@kid, @prize, @purchase)
    else
      redirect_to kid_prizes_path(@kid, @prize)
    end
  end
end
