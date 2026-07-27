# Demo family + a starter shelf of public-domain books (Project Gutenberg).
# Run with: bin/rails db:seed
demo = User.find_or_create_by!(email_address: "demo@readcoin.app") do |u|
  u.password = "password123"
end

demo.kids.find_or_create_by!(name: "Leo") { |k| k.age = 8; k.avatar = "🦁"; k.pin = "1234" }
demo.kids.find_or_create_by!(name: "Maya") { |k| k.age = 10; k.avatar = "🦄"; k.pin = "5678" }

books = [
  {
    title: "The Tale of Peter Rabbit", author: "Beatrix Potter", genre: "Animals",
    min_age: 4, max_age: 8, reward: 10,
    source_url: "https://www.gutenberg.org/cache/epub/14838/pg14838-images.html",
    summary: "Naughty Peter Rabbit sneaks into Mr. McGregor's garden against his mother's warning, loses his jacket and shoes, and barely escapes to make it home for chamomile tea.",
    quiz: [
      { "question" => "Where did Peter's mother tell him NOT to go?", "choices" => [ "The forest", "Mr. McGregor's garden", "The river", "The market" ], "answer" => 1 },
      { "question" => "What happened to Peter's jacket?", "choices" => [ "He lost it in the garden", "He gave it away", "It shrank in the rain", "A bird took it" ], "answer" => 0 },
      { "question" => "Who chased Peter around the garden?", "choices" => [ "A fox", "A dog", "Mr. McGregor", "His sisters" ], "answer" => 2 },
      { "question" => "What did Peter's mother give him at bedtime?", "choices" => [ "Blackberries", "A carrot", "Chamomile tea", "Warm milk" ], "answer" => 2 },
      { "question" => "What were the names of Peter's sisters?", "choices" => [ "Flopsy, Mopsy and Cotton-tail", "Daisy, Rosie and Lily", "Hazel, Ivy and Fern", "Poppy, Pip and Plum" ], "answer" => 0 }
    ]
  },
  {
    title: "The Wonderful Wizard of Oz", author: "L. Frank Baum", genre: "Fantasy",
    min_age: 7, max_age: 12, reward: 25,
    source_url: "https://www.gutenberg.org/cache/epub/55/pg55-images.html",
    summary: "A cyclone carries Dorothy and her dog Toto from Kansas to the land of Oz, where she follows the yellow brick road with a Scarecrow, a Tin Woodman, and a Cowardly Lion to ask the Wizard to send her home."
  },
  {
    title: "Alice's Adventures in Wonderland", author: "Lewis Carroll", genre: "Fantasy",
    min_age: 8, max_age: 12, reward: 25,
    source_url: "https://www.gutenberg.org/cache/epub/11/pg11-images.html",
    summary: "Alice follows a White Rabbit down a rabbit hole into a nonsense world of talking creatures, a mad tea party, and the fearsome Queen of Hearts."
  },
  {
    title: "The Jungle Book", author: "Rudyard Kipling", genre: "Adventure",
    min_age: 8, max_age: 13, reward: 30,
    source_url: "https://www.gutenberg.org/cache/epub/236/pg236-images.html",
    summary: "Mowgli, a boy raised by wolves in the Indian jungle, learns the Law of the Jungle from Baloo the bear and Bagheera the panther while the tiger Shere Khan hunts him."
  }
]

books.each do |attrs|
  quiz_questions = attrs.delete(:quiz)
  book = Book.find_or_create_by!(title: attrs[:title]) { |b| b.assign_attributes(attrs) }
  book.create_quiz!(questions: quiz_questions) if quiz_questions && book.quiz.nil?
end

[ { title: "Movie night pick", emoji: "🍿", cost: 20 },
  { title: "Trip to the zoo", emoji: "🦓", cost: 60 },
  { title: "New LEGO set", emoji: "🧱", cost: 100 } ].each do |attrs|
  demo.rewards.find_or_create_by!(title: attrs[:title]) { |r| r.assign_attributes(attrs) }
end

puts "Seeded: demo@readcoin.app / password123 — kids Leo (PIN 1234) & Maya (PIN 5678), #{Book.count} books, #{demo.rewards.count} rewards."
