class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  belongs_to :user

  enum status: [:cart, :checked_out]

  def update_totals
    total = line_items.pluck(:price).sum
    loyality_discount = LoyalityDiscountCalculator.loyality_discount(user, total)
    update(total: total, loyality_discount: loyality_discount)
  end
end
