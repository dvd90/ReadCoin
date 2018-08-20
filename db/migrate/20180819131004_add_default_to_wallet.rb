class AddDefaultToWallet < ActiveRecord::Migration[5.2]
  def change
    change_column :kids, :wallet, :integer, default: 0
  end
end
