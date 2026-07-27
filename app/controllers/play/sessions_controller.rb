module Play
  class SessionsController < BaseController
    skip_before_action :require_kid!
    rate_limit to: 10, within: 1.minute, only: :create, with: -> { redirect_to play_root_path, alert: "Too many tries — take a break!" }

    # Step 1: pick the family (or reuse the signed-in parent / remembered family)
    def new
      @family = current_family
      @kids = @family&.kids
    end

    def pick_family
      family = User.find_by(email_address: params[:email_address].to_s.strip.downcase)
      if family
        session[:play_family_id] = family.id
        redirect_to play_root_path
      else
        redirect_to play_root_path, alert: "We couldn't find that family email."
      end
    end

    # Step 2: PIN pad for the chosen kid
    def pin
      @kid = current_family&.kids&.find(params[:id])
      redirect_to play_root_path unless @kid
    end

    def create
      kid = current_family&.kids&.find(params[:id])
      if kid&.authenticate_pin(params[:pin].to_s)
        session[:kid_id] = kid.id
        redirect_to play_dashboard_path
      else
        redirect_to play_pin_path(params[:id]), alert: "Wrong PIN — try again!"
      end
    end

    def destroy
      session.delete(:kid_id)
      redirect_to play_root_path
    end

    private

    def current_family
      @current_family ||=
        if authenticated?
          Current.session.user
        elsif session[:play_family_id]
          User.find_by(id: session[:play_family_id])
        end
    end
    helper_method :current_family
  end
end
