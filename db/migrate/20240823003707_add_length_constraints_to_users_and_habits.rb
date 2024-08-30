class AddLengthConstraintsToUsersAndHabits < ActiveRecord::Migration[7.2]
  def change
    change_column :habits, :name, :string, limit: 255
  end
end
