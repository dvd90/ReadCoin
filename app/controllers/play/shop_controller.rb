module Play
  class ShopController < BaseController
    def index
      @rewards = current_kid.parent.rewards.order(:cost)
      @redemptions = current_kid.redemptions.order(created_at: :desc).includes(:reward)
    end

    def redeem
      reward = current_kid.parent.rewards.find(params[:reward_id])
      Redemption.redeem!(kid: current_kid, reward:)
      redirect_to play_shop_path, notice: "You got it! A grown-up will make it happen. 🎉"
    rescue Redemption::InsufficientCoins
      redirect_to play_shop_path, alert: "Not enough coins yet — keep reading!"
    end
  end
end
