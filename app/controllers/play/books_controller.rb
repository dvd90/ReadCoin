module Play
  class BooksController < BaseController
    before_action :set_book, except: :index

    def index
      @books = Book.for_age(current_kid.age || 8).order(:title).includes(:quiz)
      @readings = current_kid.readings.index_by(&:book_id)
    end

    def show
      @reading = current_kid.readings.find_by(book: @book)
    end

    def start
      current_kid.readings.find_or_create_by!(book: @book)
      redirect_to read_play_book_path(@book)
    end

    def read
      @reading = current_kid.readings.find_by(book: @book)
      redirect_to play_book_path(@book) unless @reading
    end

    def quiz
      @reading = current_kid.readings.find_by(book: @book)
      @quiz = @book.quiz
      if @reading.nil?
        redirect_to play_book_path(@book)
      elsif @quiz.nil? || @quiz.questions.blank?
        redirect_to play_book_path(@book), alert: "This book has no quiz yet — ask a grown-up to add one!"
      end
    end

    def submit_quiz
      reading = current_kid.readings.find_by(book: @book)
      quiz = @book.quiz
      return redirect_to(play_book_path(@book)) unless reading && quiz

      already_finished = reading.finished?
      score = quiz.grade(params[:answers]&.to_unsafe_h)
      reading.finish_with_score!(score)
      redirect_to play_book_path(@book, score:, earned: (!already_finished && reading.finished?) ? reading.coins_earned : nil)
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end
  end
end
