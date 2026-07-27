class CreateRewards < ActiveRecord::Migration[8.1]
  def change
    create_table :rewards do |t|
      t.references :parent, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.string :emoji
      t.integer :cost

      t.timestamps
    end
  end
end
