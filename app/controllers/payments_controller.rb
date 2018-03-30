class PaymentsController < ApplicationController

  before_action :set_amount, only: :create
  def new
  end

  def create
    payment = current_cart.payments.build(user_id: current_user.id, amount: @amount)
    customer = StripeTool.create_customer(current_user.email, params[:stripeToken])
    charge = StripeTool.create_charge(customer.id, @amount)

    payment.success
    redirect_to :root, flash: { success:  t('.success') }
    rescue Stripe::CardError => e
      payment.failure
      redirect_to :root, flash: { warning: e.message }
    ensure
      payment.save_charge(charge)
  end


  private
    def set_amount
      if current_cart.can_pay?
        @amount = (current_cart.total - current_cart.loyality_discount) * 100
      else
        redirect_to addresses_path, flash: { warning: t('payments.choose_address') }
      end
    end
end

