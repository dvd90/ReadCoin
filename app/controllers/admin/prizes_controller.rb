class Admin::PrizesController < ApplicationController
  def index
    @prizes = Prize.all
  end

  def new
    @prize = Prize.new
  end

  def create
    @prize = Prize.new(prize_params)
    if @prize.save
      redirect_to admin_prizes_path
    else
      render :new
    end
  end

  def edit
    @prize = Prize.find(params[:id])
  end

  def update
    @prize = Prize.find(params[:id])
    @prize.update(prize_params)
    if @prize.save!
      redirect_to admin_prizes_path
    else
      render :edit
    end
  end

  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy
    redirect_to admin_prizes_path
  end

  private

  def prize_params
    params.require(:prize).permit(:title, :price, :picture)
  end
end
