class Book < ApplicationRecord
  has_many :readings, dependent: :destroy
  has_many :kids, through: :readings
  validates :title, presence: true
  validates :url, presence: true
  validates :genre, presence: true
  validates :reward, presence: true
  serialize :quiz
end
