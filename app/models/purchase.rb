class Purchase < ApplicationRecord
  belongs_to :prize
  belongs_to :kid
  validates :kid_id, presence: true
  validates :prize_id, presence: true
end
