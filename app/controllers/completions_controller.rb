class CompletionsController < ApplicationController
  def create
    @habit = Habit.find(params[:habit_id])
    @completion = @habit.completions.build(user: current_user, completed_at: Date.today)

    @completion.save
    redirect_to habits_path, notice: "お疲れ様でした！"
  end
end
