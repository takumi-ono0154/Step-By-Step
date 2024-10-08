class AddStartDateToWeeklyPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :weekly_plans, :start_date, :date, null: true
    WeeklyPlan.update_all(start_date: Date.today)
    change_column_null :weekly_plans, :start_date, false
  end
end
