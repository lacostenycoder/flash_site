class SessionsController < ApplicationController

  before_action :ban_user, only: :new

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Logged In!'
      redirect_to root_url
    else
      flash.now[:warning] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_url
  end


  def ban_user
    if current_user
      flash[:warning] = "You are already logged in"
      redirect_to root_url
    end
  end
end
