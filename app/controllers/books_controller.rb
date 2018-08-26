class BooksController < ApplicationController
  def show
    @kid = Kid.find(params[:kid_id])
    @book = Book.find(params[:id])
  end

  def quiz
    @kid = Kid.find(params[:kid_id])
    @book = Book.find(params[:book_id])
  end

  def check_quiz
    @user = current_user
    @kid = Kid.find(params[:kid_id])
    @book = Book.find(params[:book_id])
    @answered_quiz = params[:quiz]
    @score = 0
    @answered_quiz.each do |key, value|
      @score += 20 if value == "true"
    end
    if @score == 100
      @kid.wallet += @book.reward
      @kid.save!
      @user.wallet -= Money.new((@book.reward * 100), 'USD')
      @user.save!
    end
    redirect_to kid_book_answers_quiz_path(@kid, @book, @score)
  end

  def answers_quiz
    @kid = Kid.find(params[:kid_id])
    @book = Book.find(params[:book_id])
    @score = params[:score]
  end

end
