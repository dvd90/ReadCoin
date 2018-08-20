class KidsController < ApplicationController
  def login
    @kids = current_user.kid
    @user = current_user
    @kid_password = ''
  end
end
