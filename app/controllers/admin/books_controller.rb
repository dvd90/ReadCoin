class Admin::BooksController < ApplicationController
  def index
    @books = Book.all
  end
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save!
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
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

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save!
      redirect_to admin_books_path
    else
      render :update
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end

  private

  def book_params
    ps = params.require(:book).permit(:title, :url, :quiz, :reward, :genre, :min_age, :max_age, :author, :summary, :photo)
    ps[:quiz] = JSON.load(ps[:quiz])
    ps
  end
end
