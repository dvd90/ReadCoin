class Reading < ApplicationRecord
  PASS_SCORE = 80

  belongs_to :kid
  belongs_to :book

  scope :in_progress, -> { where(status: "reading") }
  scope :finished, -> { where(status: "finished") }

  validates :kid_id, uniqueness: { scope: :book_id }

  # Grades a quiz submission exactly once. Re-submitting a passed quiz never re-credits coins.
  def finish_with_score!(score)
    with_lock do
      return if finished?

      self.quiz_score = [ score, quiz_score.to_i ].max
      if score >= PASS_SCORE
        self.status = "finished"
        self.coins_earned = book.reward
        kid.coins += book.reward
        kid.record_reading_day!
      end
      save!
    end
  end

  def finished? = status == "finished"
end
