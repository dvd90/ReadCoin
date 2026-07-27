module Family
  class BaseController < ApplicationController
    layout "family"

    private

    def current_parent = Current.session.user
    helper_method :current_parent
  end
end
