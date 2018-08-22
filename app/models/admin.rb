class Admin < ApplicationRecord
  validates :password, presence: true
end
