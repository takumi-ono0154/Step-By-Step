class Habit < ApplicationRecord
  belongs_to :user
  has_many :weekly_plans, dependent: :destroy
  has_many :completions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :target_date, presence: true
  validates :target_frequency, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :target_volume_hours, :target_volume_minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :start_date, presence: true

  def current_week
    ((Date.today - created_at.to_date).to_i / 7).to_i + 1
  end

  # 現在の週次プランを取得
  def current_weekly_plan
    current_week_number = current_week
    weekly_plans.find_by(week: current_week_number)
  end
end
