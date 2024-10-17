require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  let!(:user) { create(:user) }

  describe "POST /users/sign_in" do
    context "有効な認証情報を使用した場合" do
      it "ユーザーをログインさせ、ユーザーの詳細ページにリダイレクトする" do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'password123'
          }
        }

        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "無効な認証情報を使用した場合" do
      it "ユーザーをログインさせず、サインインページを再表示する" do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'wrongpassword'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("ログイン")
      end
    end
  end

  describe "POST /users" do
    context "有効なユーザー情報を使用した場合" do
      it "新しいユーザーを作成し、ユーザーの詳細ページにリダイレクトする" do
        post users_path, params: {
          user: {
            name: '新しいユーザー',
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(user_path(User.last))
      end
    end

    context "無効なユーザー情報を使用した場合" do
      it "ユーザーを作成せず、サインアップページを再表示する" do
        post users_path, params: {
          user: {
            name: '',
            email: 'invalidemail',
            password: 'short',
            password_confirmation: 'short'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("サインアップ")
      end
    end
  end

  describe "PATCH /users/:id" do
    it "有効な情報でユーザーを更新した場合" do
      patch user_path(user), params: {
        user: {
          name: '更新されたユーザー名'
        }
      }
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe "DELETE /users/:id" do
    it "ユーザーを削除し、サインインページにリダイレクトする" do
      delete user_path(user)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
