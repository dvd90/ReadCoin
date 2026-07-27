class CreateReadings < ActiveRecord::Migration[8.1]
  def change
    create_table :readings do |t|
      t.references :kid, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :status, null: false, default: "reading"
      t.integer :quiz_score
      t.integer :coins_earned

      t.timestamps
    end
  end
end
