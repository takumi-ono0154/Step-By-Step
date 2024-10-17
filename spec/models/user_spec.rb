require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効なユーザー' do
      user = User.new(name: 'テストユーザー', email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end

    it '名前が空の場合は無効' do
      user = User.new(name: '', email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'メールが空の場合は無効' do
      user = User.new(name: 'テストユーザー', email: '', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'メールが重複する場合は無効' do
      User.create(name: '既存ユーザー', email: 'duplicate@example.com', password: 'password')
      user = User.new(name: 'テストユーザー', email: 'duplicate@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe '.create_guest_user' do
    it 'ゲストユーザーを作成する' do
      guest_user = User.create_guest_user
      expect(guest_user).to be_valid
      expect(guest_user.email).to match(/guest_\w+@example.com/)
      expect(guest_user.name).to start_with('ゲストユーザー_')
      expect(guest_user.password).to be_present
    end
  end
end
