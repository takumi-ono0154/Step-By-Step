class Habit < ApplicationRecord
  belongs_to :user, optional: true  # optional: trueでuser_idのバリデーションを一時的に無効化

  validates :name, presence: true, length: { maximum: 255 }
  validates :target_date, presence: true
  validates :target_frequency, presence: true

  # ユーザー登録が必要な機能を使うときにuser_idのバリデーションを有効にするメソッド
  def require_user!
    validates :user_id, presence: true
  end
end
