class RemoveWalletRdCfromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :wallet_rdc, :integer
  end
end
