module Play
  class DashboardsController < BaseController
    def show
      @in_progress = current_kid.readings.in_progress.includes(:book)
      @finished_count = current_kid.finished_count
      @next_books = Book.for_age(current_kid.age || 8).where.not(id: current_kid.book_ids).limit(4)
    end
  end
end
