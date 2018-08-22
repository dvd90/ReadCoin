class Kid < ApplicationRecord
  belongs_to :parent, class_name: 'User'
  has_many :readings, dependent: :destroy
  has_many :books, through: :readings
  has_many :purchases, dependent: :destroy
  has_many :prizes, through: :purchases
  validates :parent_id, presence: true
  validates :name, presence: true
  validates :password, presence: true
  mount_uploader :avatar, PhotoUploader
end
