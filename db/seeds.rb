
require 'open-uri'

# def seed_image(file_name)
#  File.open(File.join(Rails.root, "/app/assets/images/#{file_name}"))
# end

User.destroy_all
Kid.destroy_all
Book.destroy_all
Prize.destroy_all

User.create!(
  email: 'admin@readcoin.com',
  password: 'admin1234',
  admin: true
  )

puts "finished seeding"


# {"Q1": [["A1", false], ["A2", false], ["A3", true], ["A4", false]],
#   "Q2": [["A1", true], ["A2", false], ["A3", false], ["A4", false]],
#   "Q3": [["A1", false], ["A2", false], ["A3", false], ["A4", true]],
#   "Q4": [["A1", false], ["A2", true], ["A3", false], ["A4", false]],
#   "Q5": [["A1", false], ["A2", true], ["A3", false], ["A4", false]]}
