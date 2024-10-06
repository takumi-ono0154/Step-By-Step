class AddProviderAndUidToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string

    remove_column :users, :line_user_id, :string
  end
end
