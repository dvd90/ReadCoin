class AddWalletToUsers < ActiveRecord::Migration[5.2]
  def change
    add_monetize :users, :wallet, currency: { present: false }
  end
end
