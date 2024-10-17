FactoryBot.define do
  factory :habit do
    association :user
    name { "習慣_#{SecureRandom.hex(3)}" }
    target_date { Date.today + 7.days }
    target_frequency { 1 }
    target_volume_hours { 1 }
    target_volume_minutes { 30 }
  end
end
