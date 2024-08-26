class AddLengthConstraintsToUsersAndHabits < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :name, :string, limit: 255
    change_column :users, :email, :string, limit: 255
    change_column :habits, :name, :string, limit: 255
  end
end
