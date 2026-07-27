module Family
  class RewardsController < BaseController
    before_action :set_reward, only: %i[edit update destroy]

    def index
      @rewards = current_parent.rewards.order(:cost)
    end

    def new
      @reward = current_parent.rewards.new
    end

    def create
      @reward = current_parent.rewards.new(reward_params)
      if @reward.save
        redirect_to family_rewards_path, notice: "Reward added."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @reward.update(reward_params)
        redirect_to family_rewards_path, notice: "Saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @reward.destroy
      redirect_to family_rewards_path, notice: "Removed."
    end

    private

    def set_reward
      @reward = current_parent.rewards.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:title, :emoji, :cost)
    end
  end
end
