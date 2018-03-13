class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: current_user_id)
  end

  def current_user_id
    cookies.signed[:user_id] || session[:user_id]
  end

end
