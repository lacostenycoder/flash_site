class ApplicationController < ActionController::Base
  helper_method :current_user, :current_cart

  def current_user
    @current_user ||= User.find_by(id: current_user_id)
  end

  def current_user_id
    cookies.signed[:user_id] || session[:user_id]
  end

  def current_cart
    @current_cart ||= (current_user.addressed_cart || current_user.cart) if current_user
  end
end

