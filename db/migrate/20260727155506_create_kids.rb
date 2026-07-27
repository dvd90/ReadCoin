class CreateKids < ActiveRecord::Migration[8.1]
  def change
    create_table :kids do |t|
      t.string :name
      t.references :parent, null: false, foreign_key: { to_table: :users }
      t.string :pin_digest
      t.string :avatar
      t.integer :age
      t.integer :coins, null: false, default: 0
      t.integer :streak, null: false, default: 0
      t.date :last_read_on

      t.timestamps
    end
  end
end
