class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :kids, foreign_key: :parent_id, inverse_of: :parent, dependent: :destroy
  has_many :rewards, foreign_key: :parent_id, inverse_of: :parent, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
