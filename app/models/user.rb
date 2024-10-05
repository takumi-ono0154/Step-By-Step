class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :completions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :line_user_id, uniqueness: true, allow_nil: true

  def self.create_guest_user
    email = generate_random_email
    password = SecureRandom.hex(10)
    name = generate_random_username

    User.create!(email: email, password: password, name: name)
  end

  private

  # ランダムなメールアドレスを生成するメソッド
  def self.generate_random_email
    "guest_#{SecureRandom.hex(5)}@example.com"
  end

  # ランダムなユーザーネームを生成するメソッド
  def self.generate_random_username
    "ゲストユーザー_#{SecureRandom.hex(3)}"
  end
end
