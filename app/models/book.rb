class Book < ApplicationRecord
  has_one :quiz, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :kids, through: :readings

  validates :title, :author, :genre, :source_url, presence: true
  validates :reward, numericality: { greater_than: 0 }

  scope :for_age, ->(age) { where("min_age IS NULL OR min_age <= ?", age).where("max_age IS NULL OR max_age >= ?", age) }
end
