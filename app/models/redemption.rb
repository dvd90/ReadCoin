class Redemption < ApplicationRecord
  belongs_to :kid
  belongs_to :reward

  scope :pending, -> { where(status: "pending") }

  class InsufficientCoins < StandardError; end

  # Deducts coins and creates the redemption atomically; raises if the kid can't afford it.
  def self.redeem!(kid:, reward:)
    kid.with_lock do
      raise InsufficientCoins if kid.coins < reward.cost

      kid.decrement!(:coins, reward.cost)
      create!(kid:, reward:)
    end
  end

  def approve! = update!(status: "approved")
end
