class BooksController < ApplicationController
  def show
    @kid = Kid.find(params[:kid_id])
    @book = Book.find(params[:id])
  end
end
