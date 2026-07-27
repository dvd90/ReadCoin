require "test_helper"

class PlayFlowTest < ActionDispatch::IntegrationTest
  setup do
    @parent = User.create!(email_address: "parent@example.com", password: "password123")
    @kid = @parent.kids.create!(name: "Leo", age: 8, avatar: "🦁", pin: "1234")
    @book = Book.create!(title: "Test Book", author: "A. Author", genre: "Adventure",
                         source_url: "https://example.com/book", reward: 10, min_age: 5, max_age: 12)
    @book.create_quiz!(questions: [
      { "question" => "Q1?", "choices" => [ "a", "b" ], "answer" => 1 },
      { "question" => "Q2?", "choices" => [ "a", "b" ], "answer" => 0 }
    ])
    @reward = @parent.rewards.create!(title: "Movie night", emoji: "🍿", cost: 5)
  end

  def kid_login
    post play_pick_family_path, params: { email_address: @parent.email_address }
    post play_session_path(@kid), params: { pin: "1234" }
    follow_redirect!
    assert_response :success
  end

  test "kid logs in with PIN, wrong PIN rejected" do
    post play_pick_family_path, params: { email_address: @parent.email_address }
    post play_session_path(@kid), params: { pin: "9999" }
    assert_redirected_to play_pin_path(@kid)

    post play_session_path(@kid), params: { pin: "1234" }
    assert_redirected_to play_dashboard_path
  end

  test "kid reads a book, passes quiz, earns coins once, and redeems a reward" do
    kid_login
    post start_play_book_path(@book)
    get quiz_play_book_path(@book)
    assert_response :success
    assert_no_match "answer", response.body.scan(/data-answer/).join, "answers must not leak to the client"

    post submit_quiz_play_book_path(@book), params: { answers: { "0" => "1", "1" => "0" } }
    assert_equal 10, @kid.reload.coins
    assert_equal 1, @kid.current_streak

    # Resubmitting must not double-credit
    post submit_quiz_play_book_path(@book), params: { answers: { "0" => "1", "1" => "0" } }
    assert_equal 10, @kid.reload.coins

    post play_redeem_path(@reward)
    assert_equal 5, @kid.reload.coins
    assert_equal "pending", @kid.redemptions.last.status
  end

  test "failing quiz earns nothing" do
    kid_login
    post start_play_book_path(@book)
    post submit_quiz_play_book_path(@book), params: { answers: { "0" => "0", "1" => "1" } }
    assert_equal 0, @kid.reload.coins
    assert_not @kid.readings.find_by(book: @book).finished?
  end

  test "kid area requires kid session" do
    get play_dashboard_path
    assert_redirected_to play_root_path
  end
end
