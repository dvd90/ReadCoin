class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @show_navbar = false
  end
  def login
  end
end
