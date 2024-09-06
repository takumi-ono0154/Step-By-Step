class UpdateHabitsTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :habits, :target_volume, :integer
    add_column :habits, :target_volume_hours, :integer
    add_column :habits, :target_volume_minutes, :integer
  end
end
