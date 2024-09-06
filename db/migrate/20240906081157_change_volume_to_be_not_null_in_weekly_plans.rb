class ChangeVolumeToBeNotNullInWeeklyPlans < ActiveRecord::Migration[7.2]
  def change
    change_column_null :weekly_plans, :volume, false
  end
end
