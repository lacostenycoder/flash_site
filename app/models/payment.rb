class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  state_machine :state, initial: :balance_due do
    after_transition :balance_due => :paid, do: :set_order_success
    after_transition :balance_due => :failed, do: :set_order_failure

    event :success do
      transition :balance_due => :paid
    end

    event :failure do
      transition :balance_due => :failed
    end
  end

  def set_order_success
    order.pay
    PaymentMailer.successful_payment(user.id).deliver_later
  end

  def set_order_failure
    order.mark_fail
    PaymentMailer.failed_payment(user.id).deliver_later
  end

  def save_charge(charge)
    self.card_token = charge.id
    self.failure_message = charge.failure_message
    save
  end
end
