class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @show_navbar = true
  end
  def login
  end
end
