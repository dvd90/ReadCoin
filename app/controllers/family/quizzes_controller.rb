module Family
  class QuizzesController < BaseController
    before_action :set_book

    def edit
      @quiz = @book.quiz || @book.build_quiz(questions: [])
    end

    def update
      @quiz = @book.quiz || @book.build_quiz
      @quiz.questions = parse_questions
      if @quiz.save
        redirect_to family_books_path, notice: "Quiz saved for #{@book.title}."
      else
        flash.now[:alert] = @quiz.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    end

    def generate
      @quiz = @book.quiz || @book.build_quiz
      @quiz.questions = QuizGenerator.generate(@book)
      @quiz.save!
      redirect_to edit_family_book_quiz_path(@book), notice: "Quiz generated — review it below."
    rescue QuizGenerator::Error => e
      redirect_to edit_family_book_quiz_path(@book), alert: e.message
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end

    # Quiz form posts questions as nested fields:
    # questions[0][question], questions[0][choices][], questions[0][answer]
    def parse_questions
      (params[:questions] || {}).values.filter_map do |q|
        choices = Array(q[:choices]).map(&:strip).reject(&:blank?)
        next if q[:question].blank? && choices.empty?

        { "question" => q[:question].to_s.strip, "choices" => choices, "answer" => q[:answer].to_i }
      end
    end
  end
end
