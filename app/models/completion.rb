class Completion < ApplicationRecord
  belongs_to :habit
  belongs_to :user

  validates :completed_at, presence: true
end
