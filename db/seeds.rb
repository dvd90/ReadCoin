require 'faker'

User.destroy_all
Kid.destroy_all
Ebook.destroy_all
Prize.destroy_all

puts "creating user"
user = User.create!(
  username: 'readcoin',
  email: '1234@1234.com',
  password: '1234'
  )

puts "creating kids"
kid = Kid.create!(
  name: 'kid',
  password: '1',
  age: '8',
  intreset: 'sci-fi',
  wallet: '150',
  avatar: url)

kid = Kid.create!(
  name: 'kid2',
  password: '2'
  age: Faker::Number.non_zero_digit
  interest:
  wallet:
  avatar:
  )

puts "creating ebooks.."

5.times do
  ebook = Ebook.create!(
    title:
    url:
    quiz:
    readcoin: Faker::Number.between(1, 10)
    )
end

puts "creating prizes.."

5.times do
  prize = Prize.create!(
  price: Faker::Number.non_zero_digit,
  title:
  picture:
 )

end
