# Questions are stored as JSON: [{ "question" => "...", "choices" => ["a", "b", "c", "d"], "answer" => 2 }, ...]
# The answer index never leaves the server — grading happens in #grade.
class Quiz < ApplicationRecord
  belongs_to :book

  validate :questions_are_well_formed

  def grade(submitted)
    submitted ||= {}
    correct = questions.each_with_index.count do |q, i|
      submitted[i.to_s].to_i == q["answer"].to_i
    end
    (correct * 100.0 / questions.size).round
  end

  private

  def questions_are_well_formed
    unless questions.is_a?(Array) && questions.any? && questions.all? { |q|
      q.is_a?(Hash) && q["question"].present? && q["choices"].is_a?(Array) && q["choices"].size >= 2 &&
        q["answer"].to_i.between?(0, q["choices"].size - 1)
    }
      errors.add(:questions, "must be a non-empty list of {question, choices, answer}")
    end
  end
end
