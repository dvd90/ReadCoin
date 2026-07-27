module Family
  class DashboardsController < BaseController
    def show
      @kids = current_parent.kids.includes(:readings)
      @pending_redemptions = Redemption.pending.joins(:reward).where(rewards: { parent_id: current_parent.id }).includes(:kid, :reward)
      @recent_readings = Reading.finished.where(kid: @kids).order(updated_at: :desc).limit(10).includes(:kid, :book)
    end
  end
end
