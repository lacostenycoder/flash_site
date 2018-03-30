class LoyalityDiscountCalculator
  def self.loyality_discount(user, total)
    number_of_orders = user.orders.where(state: :paid).count
    discount = 5
    if number_of_orders <= 5
      discount = number_of_orders
    end

    loyality_discount = total * (discount/100.0)
  end
end
