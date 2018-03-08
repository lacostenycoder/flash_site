class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, allow_nil: true, presence: true
  has_secure_password
end
