class Habit < ApplicationRecord
  belongs_to :user
  has_many :weekly_plans, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :target_date, presence: true
  validates :target_frequency, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :target_volume_hours, :target_volume_minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
end
