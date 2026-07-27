class CreateQuizzes < ActiveRecord::Migration[8.1]
  def change
    create_table :quizzes do |t|
      t.references :book, null: false, foreign_key: true
      t.json :questions

      t.timestamps
    end
  end
end
