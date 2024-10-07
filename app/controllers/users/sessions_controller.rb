# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.create_guest_user
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to user_path(user)
  end
end
