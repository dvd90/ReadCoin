class CreateRedemptions < ActiveRecord::Migration[8.1]
  def change
    create_table :redemptions do |t|
      t.references :kid, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
