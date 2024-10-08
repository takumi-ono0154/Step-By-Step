class AddStartDateToWeeklyPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :weekly_plans, :start_date, :date, null: false
  end
end
