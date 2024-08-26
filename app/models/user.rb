class User < ApplicationRecord
  has_many :habits

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :crypted_password, presence: true
  validates :salt, presence: true
end
