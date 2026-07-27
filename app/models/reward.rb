class Reward < ApplicationRecord
  belongs_to :parent, class_name: "User", inverse_of: :rewards
  has_many :redemptions, dependent: :destroy

  validates :title, presence: true
  validates :cost, numericality: { greater_than: 0 }
end
