class CompletionsController < ApplicationController
  def create
    @habit = Habit.find(params[:habit_id])
    @completion = @habit.completions.build(user: current_user, completed_at: Date.today)

    if @completion.save
      redirect_to habits_path, notice: "習慣を達成しました！"
    else
      redirect_to habits_path, alert: "エラーが発生しました。"
    end
  end
end
