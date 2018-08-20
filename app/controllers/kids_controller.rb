class KidsController < ApplicationController
  def login
    @user = current_user
  end
  def create_login
    @user = current_user
    @kids = @user.kids
    password_check = false
    @kids.each do |kid|
      if login_params[:password] == kid.password
        password_check = true
        @kid = kid
      end
    end
    if password_check
      redirect_to kid_dashboard_path(@kid)
    else
      render :login
    end
  end

  def kid_dashboard
    @kid = Kid.find(params[:id])
  end

  private

  def login_params
    params.require('/login').permit(:password)
  end

end
