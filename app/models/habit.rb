class Habit < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :target_date, presence: true
  validates :target_frequency, presence: true
end
