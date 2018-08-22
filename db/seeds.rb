
require 'faker'
require 'open-uri'

# def seed_image(file_name)
#  File.open(File.join(Rails.root, "/app/assets/images/#{file_name}"))
# end

User.destroy_all
Kid.destroy_all
Book.destroy_all
Prize.destroy_all

puts "creating user"
 user = User.create!(
  email: '1234@gmail.com',
  password: '123456'

  )

puts "creating kids"
 Kid.create!(
  name: 'Alex',
  password: '1',
  age: 8,
  interests: 'sci-fi',
  wallet: 150,
  avatar: "alex.png",
  parent_id: user.id
  )

 Kid.create!(
  name: 'Sam',
  password: '2',
  age: 10,
  interests: 'fashion',
  wallet: 100,
  avatar: "sam.png",
  parent_id: user.id
  )

puts "creating ebooks.."

5.times do
 Book.create!(
    title: Faker::Book.title,
    url: 'http://www.planetpublish.com/wp-content/uploads/2011/11/The_Jungle_Book_T.pdf',
    author: Faker::Book.author,
    summary: 'it was a wonder day as i walk in the forest...',
    quiz: 'who many birds in the sky?',
    reward: Faker::Number.between(1, 15),
    genre: 'sci-fi',
    min_age: 5,
    max_age: 10
    )
end
Book.create!(
  title: Faker::Book.title,
    url: 'http://www.planetpublish.com/wp-content/uploads/2011/11/The_Jungle_Book_T.pdf',
    author: Faker::Book.author,
    summary: 'it was a wonder day as i walk in the forest...',
    quiz: 'who many birds in the sky?',
    reward: Faker::Number.between(1, 15),
    genre: 'fashion',
    min_age: 8,
    max_age: 12
    )

puts "creating prizes.."

5.times do
  Prize.create!(
  price: Faker::Number.non_zero_digit,
  title: Faker::Commerce.product_name,
  picture: Faker::LoremPixel.image("60x60", true)
 )

end



puts "finished seeding"
