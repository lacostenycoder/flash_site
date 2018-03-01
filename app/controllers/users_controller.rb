class UsersController < ApplicationController

  before_action :ban_user, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Thank you for signing up!'
      redirect_to root_url
    else
      flash.now[:info] = 'Try again'
      render :new
    end
  end

  private
  def allowed_params
    params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation)
  end

  def ban_user
    if current_user
      flash[:warning] = "You are already logged in"
      redirect_to root_url
    end
  end
end
