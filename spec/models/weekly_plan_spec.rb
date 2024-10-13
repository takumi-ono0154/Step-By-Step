require 'rails_helper'

RSpec.describe WeeklyPlan, type: :model do
  let!(:user) { User.create(name: 'テストユーザー', email: 'test@example.com', password: 'password') }
  let!(:habit) { Habit.create(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30, user: user) }
  let!(:weekly_plan) { WeeklyPlan.new(habit: habit) }

  describe '関連付け' do
    it 'habitとの関連付けが正しい' do
      expect(weekly_plan.habit).to eq(habit)
    end
  end
end
