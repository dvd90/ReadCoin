require "test_helper"

class FamilyFlowTest < ActionDispatch::IntegrationTest
  setup do
    @parent = User.create!(email_address: "parent@example.com", password: "password123")
    post session_path, params: { email_address: @parent.email_address, password: "password123" }
  end

  test "parent manages kids, books, quizzes and rewards" do
    get family_root_path
    assert_response :success

    post family_kids_path, params: { kid: { name: "Maya", age: 10, avatar: "🦄", pin: "5678" } }
    assert_redirected_to family_kids_path
    kid = @parent.kids.last
    assert kid.authenticate_pin("5678")
    assert_nil kid.read_attribute(:pin_digest).match(/5678/), "PIN must be hashed"

    post family_books_path, params: { book: { title: "B", author: "A", genre: "G", reward: 10,
                                              source_url: "https://example.com", min_age: 5, max_age: 10 } }
    book = Book.last
    assert_redirected_to edit_family_book_quiz_path(book)

    patch family_book_quiz_path(book), params: { questions: {
      "0" => { question: "Q?", choices: [ "x", "y" ], answer: "1" }
    } }
    assert_equal 1, book.reload.quiz.questions.size

    post family_rewards_path, params: { reward: { title: "Zoo", emoji: "🦓", cost: 50 } }
    assert_equal 1, @parent.rewards.count
  end

  test "family area requires authentication" do
    delete session_path
    get family_root_path
    assert_redirected_to new_session_path
  end
end
