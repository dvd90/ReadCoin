class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.text :summary
      t.string :cover_url
      t.string :source_url
      t.integer :min_age
      t.integer :max_age
      t.integer :reward

      t.timestamps
    end
  end
end
