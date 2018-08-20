
require 'faker'
require 'open-uri'

User.destroy_all
Kid.destroy_all
Ebook.destroy_all
Prize.destroy_all

puts "creating user"
user = User.new(
  username: 'readcoin',
  email: '1234@1234.com',
  password: '1234'
  )

puts "creating kids"
kid1 = Kid.new(
  name: 'kid',
  password: '1',
  age: '8',
  intreset: 'sci-fi',
  wallet: '150',
  avatar: Faker::Avatar.image("my-own-slug", "50x50", "jpg")
  )

kid2 = Kid.new(
  name: 'kid2',
  password: '2',
  age: Faker::Number.non_zero_digit,
  interest: 'fashion',
  wallet: '100',
  avatar: Faker::Avatar.image("my-own-slug", "50x50", "jpg")
  )

puts "creating ebooks.."

5.times do
  ebook = Ebook.new(
    title: Faker::Book.title,
    author: Faker::Book.author,
    summery: 'it was a wonder day as i walk in the forest...'
    url: 'http://www.planetpublish.com/wp-content/uploads/2011/11/The_Jungle_Book_T.pdf',
    quiz:
    readcoin: Faker::Number.between(1, 15),
    genre: Faker::Book.genre
    )
end

puts "creating prizes.."

5.times do
  prize = Prize.new(
  price: Faker::Number.non_zero_digit,
  title: Faker::Commerce.product_name,
  picture: Faker::LoremPixel.image("60x60", true)
 )

end

user.create!
kid1.create!
kid2.create!
ebook.create!
prize.create!

puts "finished seeding"

