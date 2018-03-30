class Address < ApplicationRecord
  belongs_to :user
  belongs_to :state
  belongs_to :country

  validates :street1, :street2, :city, :pincode, presence: true

  def full_address
    "#{street1} #{street2} #{city} #{State.find_by(id: state_id).name} #{Country.find_by(id: country_id).name}"
  end
end

