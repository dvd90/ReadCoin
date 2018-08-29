

Order.destroy_all
Purchase.destroy_all
User.destroy_all
Kid.destroy_all


User.create!(
  email: 'admin@readcoin.com',
  password: 'admin1234',
  admin: true,
  username: "admin"
  )

puts "finished seeding"


# {"Q1": [["A1", false], ["A2", false], ["A3", true], ["A4", false]],
#   "Q2": [["A1", true], ["A2", false], ["A3", false], ["A4", false]],
#   "Q3": [["A1", false], ["A2", false], ["A3", false], ["A4", true]],
#    "Q4": [["A1", false], ["A2", true], ["A3", false], ["A4", false]],
#   "Q5": [["A1", false], ["A2", true], ["A3", false], ["A4", false]]}
