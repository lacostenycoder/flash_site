class PaymentMailer < ApplicationMailer
  def successful_payment(user_id)
    @user = User.find_by(id: user_id)
    mail to: @user.email
  end

  def failed_payment(user_id)
    @user = User.find_by(id: user_id)
    mail to: @user.email
  end
end
