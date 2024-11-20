class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :completions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  def self.create_guest_user
    email = generate_random_email
    password = SecureRandom.hex(10)
    name = generate_random_username

    User.create!(email: email, password: password, name: name)
  end

  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end

  private

  def self.generate_random_email
    "guest_#{SecureRandom.hex(5)}@example.com"
  end

  def self.generate_random_username
    "ゲストユーザー_#{SecureRandom.hex(3)}"
  end
end
