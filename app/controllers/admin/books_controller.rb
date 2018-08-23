class Admin::BooksController < ApplicationController
  def index
    @books = Book.all
  end
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save!
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save!
      redirect_to admin_books_path
    else
      render :update
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end

  private

  def book_params
    ps = params.require(:book).permit(:title, :url, :quiz, :reward, :genre, :min_age, :max_age, :author, :summary, :photo)
    ps[:quiz] = JSON.load(ps[:quiz])
    ps
  end
end
