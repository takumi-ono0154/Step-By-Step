require 'rails_helper'

RSpec.describe Completion, type: :model do
  let!(:user) { User.create(name: 'テストユーザー', email: 'test@example.com', password: 'password') }
  let!(:habit) { Habit.create(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30, user: user) }
  let!(:completion) { Completion.new(habit: habit, user: user, completed_at: Time.now) }

  describe 'バリデーション' do
    it 'completed_atが存在する場合は有効' do
      expect(completion).to be_valid
    end

    it 'completed_atが存在しない場合は無効' do
      completion.completed_at = nil
      expect(completion).not_to be_valid
      expect(completion.errors[:completed_at]).to include("を入力してください")
    end
  end

  describe '関連付け' do
    it 'habitとの関連付けが正しい' do
      expect(completion.habit).to eq(habit)
    end

    it 'userとの関連付けが正しい' do
      expect(completion.user).to eq(user)
    end
  end
end
