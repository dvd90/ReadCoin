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
    @new_kid = Kid.new
    @categories = ["Adventure",
      "Animals",
      "Architecture",
      "Art",
      "Autobiography",
      "Biography",
      "Classics",
      "Comedy",
      "Comic Books",
      "Cooking",
      "Crafts & Hobbies",
      "Creative Writing",
      "Culture",
      "Drama",
      "Dystopian Fiction",
      "Ecology",
      "Education",
      "Entertainment",
      "Environment",
      "Fairy Tale",
      "Family",
      "Fantasy",
      "Fiction",
      "Food",
      "Friendship",
      "Futuristic",
      "Game Books",
      "Garden",
      "Graphic Novel ",
      "History",
      "Holiday",
      "Horror",
      "How-to",
      "Human Rights",
      "Humor",
      "Inspirational",
      "Judiasm",
      "Language Arts",
      "Lifestyles",
      "Literature",
      "Magic",
      "Manga",
      "Mind & Body",
      "Motivational",
      "Movies",
      "Music",
      "Mystery",
      "Mythology",
      "Nonfiction",
      "Outdoor",
      "Paranormal",
      "Personal Growth",
      "Pets",
      "Photography",
      "Picture",
      "Poetry",
      "Politics",
      "Popular Culture",
      "Relationships",
      "Religion",
      "Romance",
      "Science",
      "Science Fiction",
      "Screenplay",
      "Short Stories",
      "Social Sciences",
      "Sports",
      "Spy Fiction",
      "Superhero",
      "Supernatural",
      "Suspense",
      "Technology",
      "Thriller",
      "Travel",
      "Urban Fantasy",
      "Western",
      "World History"
    ]
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
  @kid.update(kid_params)
  if @kid.save!
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
    params.require(:kid).permit(:name, :parent_id, :password, :age, :avatar, interests: [])
  end

  def login_params
    params.require('/login').permit(:password)
  end

end
