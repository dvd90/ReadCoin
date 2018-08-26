class AddWalletRdcToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :wallet_rdc, :integer
  end
end
