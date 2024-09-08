class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: %i[show edit update destroy]

  # GET /habits or /habits.json
  def index
    @habits = Habit.all
    @habit = Habit.new  # @habitを新しく定義してエラーを防ぐ
    @weekly_plan = params[:weekly_plan] || []
  end

  # GET /habits/1 or /habits/1.json
  def show
    @habit = Habit.find(params[:id])
  end

  # GET /habits/new
  def new
    @habit = Habit.new
  end

  # GET /habits/1/edit
  def edit
  end

  # POST /habits or /habits.json
  def create
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      # 週間目標を計算
      @weekly_plan = calculate_habit_plan(
        @habit.target_date,
        @habit.target_frequency,
        @habit.target_volume_hours.to_i * 60 + @habit.target_volume_minutes.to_i
      )

      # WeeklyPlanテーブルに保存
      @weekly_plan.each do |plan|
        WeeklyPlan.create!(
          habit: @habit,
          week: plan[:week],
          frequency: plan[:frequency],
          volume: plan[:volume]
        )
      end

      # 週間目標を表示するためのビューにリダイレクト
      redirect_to habits_path, notice: "習慣目標が保存されました。"
    else
      render :new
    end
  end

  # PATCH/PUT /habits/1 or /habits/1.json
  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to habit_url(@habit), notice: "Habit was successfully updated." }
        format.json { render :show, status: :ok, location: @habit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1 or /habits/1.json
  # app/controllers/habits_controller.rb
  def destroy
    @habit.destroy!

    respond_to do |format|
      format.html { redirect_to habits_url, notice: "習慣が削除されました。" }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :target_date, :target_frequency, :target_volume_hours, :target_volume_minutes)
  end

  def calculate_habit_plan(target_date, target_frequency, target_volume_minutes)
    today = Date.today
    total_days = (target_date - today).to_i
    total_weeks = (total_days / 7.0).ceil

    # 各週の頻度を設定
    weekly_frequencies = Array.new(total_weeks) do |i|
      (target_frequency.to_f / total_weeks * (i + 1)).round
    end
    weekly_frequencies.map! { |freq| [ freq, 1 ].max }

    # 各週のボリュームを設定
    weekly_volumes = Array.new(total_weeks) do |i|
      (target_volume_minutes.to_f / total_weeks * (i + 1)).round
    end
    weekly_volumes = weekly_volumes.map { |volume| (volume / 10.0).ceil * 10 }

    # 最終週のボリュームをユーザーの目標ボリュームに設定
    weekly_volumes[-1] = target_volume_minutes

    # ボリュームの調整
    # ボリュームが0にならないように設定
    (total_weeks - 2).downto(0) do |i|
      weekly_volumes[i] = [ weekly_volumes[i + 1] - 10, 10 ].max
    end

    # 最終週の前の週のボリュームが最終週のボリュームに達しない場合の調整
    if total_weeks > 1 && weekly_volumes[-2] >= target_volume_minutes
      weekly_volumes[-2] = [ target_volume_minutes - 10, 10 ].max
    end

    # 各週ごとの計画を作成
    weekly_plan = total_weeks.times.map do |i|
      {
        week: i + 1,
        frequency: weekly_frequencies[i] || weekly_frequencies.last,
        volume: weekly_volumes[i] || weekly_volumes.last
      }
    end

    weekly_plan
  end
end
