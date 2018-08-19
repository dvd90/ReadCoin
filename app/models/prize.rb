class Prize < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :kids, through: :purchases
  validates :title, presence: true
  validates :price, presence: true
end
