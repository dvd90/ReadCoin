module Play
  class BaseController < ApplicationController
    allow_unauthenticated_access
    layout "play"

    before_action :require_kid!

    private

    def current_kid
      @current_kid ||= Kid.find_by(id: session[:kid_id])
    end
    helper_method :current_kid

    def require_kid!
      redirect_to play_root_path unless current_kid
    end
  end
end
