# Generates an age-appropriate comprehension quiz for a book via the Claude API.
# Returns an array of question hashes matching Quiz#questions, or raises
# QuizGenerator::Error with a human-readable message.
class QuizGenerator
  MODEL = :"claude-opus-5"
  QUESTION_COUNT = 5

  SCHEMA = {
    type: "object",
    additionalProperties: false,
    required: [ "questions" ],
    properties: {
      questions: {
        type: "array",
        items: {
          type: "object",
          additionalProperties: false,
          required: [ "question", "choices", "answer" ],
          properties: {
            question: { type: "string" },
            choices: { type: "array", items: { type: "string" } },
            answer: { type: "integer", description: "0-based index of the correct choice" }
          }
        }
      }
    }
  }.freeze

  class Error < StandardError; end

  def self.available? = ENV["ANTHROPIC_API_KEY"].present?

  def self.generate(book)
    raise Error, "Set ANTHROPIC_API_KEY to enable AI quiz generation." unless available?

    client = Anthropic::Client.new
    message = client.messages.create(
      model: MODEL,
      max_tokens: 4096,
      output_config: { format: { type: "json_schema", schema: SCHEMA } },
      messages: [ { role: "user", content: prompt(book) } ]
    )
    raise Error, "The model declined to generate a quiz for this book." if message.stop_reason == :refusal

    text = message.content.find { |block| block.type == :text }&.text
    raise Error, "Empty response from the model." if text.blank?

    JSON.parse(text).fetch("questions")
  rescue Anthropic::Errors::APIStatusError => e
    raise Error, "Claude API error (#{e.type}): #{e.message.to_s.truncate(200)}"
  rescue JSON::ParserError, KeyError
    raise Error, "The model returned an unexpected format — try again."
  end

  def self.prompt(book)
    ages = [ book.min_age, book.max_age ].compact.join("–")
    <<~PROMPT
      Write a reading-comprehension quiz for a child who just finished this book:

      Title: #{book.title}
      Author: #{book.author}
      Genre: #{book.genre}
      #{"Reader age: #{ages}" if ages.present?}
      #{"Summary: #{book.summary}" if book.summary.present?}

      Create exactly #{QUESTION_COUNT} multiple-choice questions with 4 choices each.
      The questions must test whether the child actually read and understood the story —
      plot events, characters, and cause-and-effect — not trivia about the author.
      Use simple, friendly language appropriate for the reader's age. Wrong choices should
      be plausible to someone who didn't read the book, but clearly wrong to someone who did.
    PROMPT
  end
end
