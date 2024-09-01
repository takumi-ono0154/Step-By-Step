class Habit < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :target_date, presence: true
  validates :target_frequency, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :target_volume, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
