class User < ApplicationRecord
  has_secure_password
  validates :fname, :lname, :email, presence: true
end
