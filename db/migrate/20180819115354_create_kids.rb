class CreateKids < ActiveRecord::Migration[5.2]
  def change
    create_table :kids do |t|
      t.string :name
      t.integer :parent_id
      t.string :password
      t.integer :age
      t.string :interests
      t.integer :wallet
      t.string :avatar

      t.timestamps
    end
  end
end
