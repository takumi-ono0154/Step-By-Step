# spec/models/habit_spec.rb
require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe 'バリデーション' do
    it '有効な習慣' do
      user = User.create(name: 'テストユーザー', email: 'test@example.com', password: 'password')
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30, user: user)
      expect(habit).to be_valid
    end

    it '名前が空の場合は無効' do
      habit = Habit.new(name: '', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30)
      expect(habit).not_to be_valid
      expect(habit.errors[:name]).to include("を入力してください")
    end

    it '目標日付が空の場合は無効' do
      habit = Habit.new(name: '運動', target_date: nil, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_date]).to include("を入力してください")
    end

    it '目標頻度が空の場合は無効' do
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: nil, target_volume_hours: 1, target_volume_minutes: 30)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_frequency]).to include("を入力してください")
    end

    it '目標頻度が0以下の場合は無効' do
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: 0, target_volume_hours: 1, target_volume_minutes: 30)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_frequency]).to include("は0より大きい値にしてください")
    end

    it '目標時間が空の場合は無効' do
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: nil, target_volume_minutes: 30)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_volume_hours]).to include("を入力してください")
    end

    it '目標時間がマイナスの場合は無効' do
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: -1, target_volume_minutes: 30)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_volume_hours]).to include("は0以上の値にしてください")
    end

    it '目標分が空の場合は無効' do
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: nil)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_volume_minutes]).to include("を入力してください")
    end

    it '目標分がマイナスの場合は無効' do
      habit = Habit.new(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: -1)
      expect(habit).not_to be_valid
      expect(habit.errors[:target_volume_minutes]).to include("は0以上の値にしてください")
    end
  end

  describe '#current_week' do
    it '現在の週を正しく計算する' do
      user = User.create(name: 'テストユーザー', email: 'test@example.com', password: 'password')
      habit = Habit.create(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30, user: user, created_at: 3.weeks.ago)
      expect(habit.current_week).to eq(4)  # 3週間前に作成された場合
    end
  end

  describe '#current_weekly_plan' do
    it '現在の週次プランを取得する' do
      user = User.create(name: 'テストユーザー', email: 'test@example.com', password: 'password')
      habit = Habit.create(name: '運動', target_date: Date.today, target_frequency: 3, target_volume_hours: 1, target_volume_minutes: 30, user: user)
      weekly_plan = habit.weekly_plans.create(week: habit.current_week)
      expect(habit.current_weekly_plan).to eq(weekly_plan)
    end
  end
end
