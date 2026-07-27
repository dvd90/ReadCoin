module Family
  class BooksController < BaseController
    before_action :set_book, only: %i[show edit update destroy]

    def index
      @books = Book.order(:title).includes(:quiz)
    end

    def show
    end

    def new
      @book = Book.new(reward: 10)
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to edit_family_book_quiz_path(@book), notice: "Book added — now give it a quiz."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @book.update(book_params)
        redirect_to family_books_path, notice: "Saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy
      redirect_to family_books_path, notice: "Removed."
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :genre, :summary, :cover_url, :source_url, :min_age, :max_age, :reward)
    end
  end
end
