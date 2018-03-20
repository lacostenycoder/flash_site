class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :deal

  validate :only_one_quantity_of_deal

  after_save :update_cart_total, :decrement_deal_quantity

  before_destroy :update_cart_total

  def only_one_quantity_of_deal
    current_user = order.user
    current_user.orders.each do |order|
      order.line_items.each do |line_item|
        if line_item.deal_id == deal_id && line_item != self
          errors.add(:base, :already_exists)
        end
      end
    end
  end

  def update_cart_total
    order.update_totals
  end

  def decrement_deal_quantity
    deal.update_quantity
  end
end
