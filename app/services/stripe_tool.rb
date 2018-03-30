class StripeTool
  def self.create_customer(email, token)
    Stripe::Customer.create(
        email: email,
        source: token
      )
  end

  def self.create_charge(customer_id, amount)
    Stripe::Charge.create(
        customer: customer_id,
        amount: amount,
        currency: "inr"
      )
  end
end
