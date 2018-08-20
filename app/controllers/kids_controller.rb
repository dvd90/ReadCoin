class KidsController < ApplicationController
  def login
    @kids = current_user.kids
    @user = current_user
    @kid_password = ''
  end
end
