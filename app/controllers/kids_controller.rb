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
    @books = Book.where(genre: @kid.interests).where("min_age < ? AND max_age > ?", @kid.age, @kid.age)
  end

  def index
    @user = current_user
    @kids = @user.kids
  end

  def show
    @kid = Kid.find(params[:id])
  end

  def new
    @kid = Kid.new
  end

  def create
    @user = current_user
    @kid = Kid.new(kid_params)
    @kid.parent_id = @user[:id]
    if @kid.save
      redirect_to kids_path
   else
     render :new
   end
 end

def edit
  @kid = Kid.find(params[:id])
end

def update
  @kid = Kid.find(params[:id])
  if @kid.update(kid_params)
    redirect_to kid_dashboard_path(@kid)
  else
    render :edit
  end
end

def destroy
  @kid = Kid.find(params[:id])
  @kid.destroy
  redirect_to kids_path
end

def create_avatar
  @kid = Kid.find(params[:kid_id])
end

private

  def kid_params
    params.require(:kid).permit(:name, :parent_id, :password, :age, :interests, :avatar)
  end

  def login_params
    params.require('/login').permit(:password)
  end

end
