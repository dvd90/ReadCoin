class Reading < ApplicationRecord
  belongs_to :kid
  belongs_to :book
  validates :kid_id, presence: true
  validates :book_id, presence: true
end
