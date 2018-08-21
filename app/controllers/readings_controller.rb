class ReadingsController < ApplicationController
  def show
    @reading = Reading.find(params[:id])
    @book = Book.find(params[:book_id])
    @kid = Kid.find(params[:kid_id])
  end

  def create
    @reading = Reading.new
    @kid = Kid.find(params[:kid_id])
    @book = Book.find(params[:book_id])
    @reading.kid = @kid
    @reading.book = @book
    if @reading.save
      redirect_to kid_book_reading_path(@kid, @book, @reading)
    else
      redirect_to kid_books_path(@kid)
    end
  end
end
