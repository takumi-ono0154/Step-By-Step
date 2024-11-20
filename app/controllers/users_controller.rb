class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    if @user != current_user
        redirect_to root_path
        return
    end

    @habits = @user.habits.includes(:weekly_plans)
    @current_weekly_plans = @habits.map do |habit|
      current_week = calculate_current_week(habit)
      habit.weekly_plans.find_by(week: current_week)
    end.compact
  end

  private

  def calculate_current_week(habit)
    ((Date.today - habit.created_at.to_date).to_i / 7).to_i + 1
  end
end
