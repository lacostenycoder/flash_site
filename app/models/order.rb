class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :deals, through: :line_items
  has_many :payments
  belongs_to :address, optional: true
  belongs_to :user

  def update_totals
    total = line_items.pluck(:price).sum
    loyality_discount = LoyalityDiscountCalculator.loyality_discount(user, total)
    update(total: total, loyality_discount: loyality_discount)
  end

# ============================
  state_machine :state, initial: :cart do
    after_transition :shipped => :delivered, do: :remove_line_items

    event :mark_address do
      transition :cart => :address
    end

    event :add_line_item do
      transition :address => :cart
    end

    event :pay do
      transition :address=> :paid
    end

    event :mark_fail do
      transition :address => :failed
    end

    # from all state can go to cancelled state
    event :cancel do
      transition all - :cart => :cancelled
    end

    # by admin
    event :ship do
      transition :paid => :shipped
    end

    # by admin
    event :deliver do
      transition :shipped => :delivered
    end
  end
# ============================

  def set_address(address_id)
    update_columns(address_id: address_id)
    mark_address
  end

  def remove_line_items
    line_items.delete_all
  end

end
