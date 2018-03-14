class Dead < ApplicationRecord
  has_many :images, dependent: :destroy
end
