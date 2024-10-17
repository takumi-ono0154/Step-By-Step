require 'rails_helper'

RSpec.describe "Habits", type: :request do
  let!(:user) { create(:user) }

  before do
    post user_session_path, params: {
      user: {
        email: user.email,
        password: 'password123' 
      }
    }
  end

  describe "GET /habits" do
    it "習慣の一覧ページを表示する" do
      get habits_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /habits/new" do
    it "新しい習慣の作成ページを表示する" do
      get new_habit_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /habits" do
    it "新しい習慣を作成し、習慣の一覧ページにリダイレクトする" do
      post habits_path, params: {
        habit: {
          name: '新しい習慣',
          target_date: Date.tomorrow,
          target_frequency: 3,
          target_volume_hours: 1,
          target_volume_minutes: 30
        }
      }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(habits_path)
    end
  end

  describe "DELETE /habits/:id" do
    let!(:habit) { create(:habit, user: user) }

    it "習慣を削除し、習慣の一覧ページにリダイレクトする" do
      delete habit_path(habit)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(habits_path)
    end
  end
end
