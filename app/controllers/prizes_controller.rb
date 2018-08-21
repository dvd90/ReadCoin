class PrizesController < ApplicationController
  def index
    @prizes = Prize.all
    @kid = Kid.find(params[:kid_id])
    @kid_balance = Kid.find(params[:kid_id]).wallet
  end

  def show
    @prize = Prize.find(params[:id])
    @kid = Kid.find(params[:kid_id]) 
  end
end
