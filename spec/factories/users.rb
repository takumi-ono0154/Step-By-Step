FactoryBot.define do
  factory :user do
    name { "ユーザー_#{SecureRandom.hex(3)}" }
    email { "user_#{SecureRandom.hex(5)}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
