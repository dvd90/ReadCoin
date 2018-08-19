class CreatePrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :prizes do |t|
      t.integer :price
      t.string :title
      t.string :picture

      t.timestamps
    end
  end
end
