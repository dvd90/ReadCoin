module Family
  class RedemptionsController < BaseController
    def index
      @redemptions = Redemption.joins(:reward).where(rewards: { parent_id: current_parent.id })
                               .order(created_at: :desc).includes(:kid, :reward)
    end

    def update
      redemption = Redemption.joins(:reward).where(rewards: { parent_id: current_parent.id }).find(params[:id])
      redemption.approve!
      redirect_back fallback_location: family_redemptions_path, notice: "Approved — don't forget to deliver it!"
    end
  end
end
