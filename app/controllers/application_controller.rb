class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if cookies.signed[:user_id]
      id = cookies.signed[:user_id]
    elsif session[:user_id]
      id = session[:user_id]
    end
    @current_user ||= User.find_by(id: id)
  end


end
