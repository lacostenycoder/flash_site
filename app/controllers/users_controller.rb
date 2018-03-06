class UsersController < ApplicationController

  before_action :prevent_current_user_from_signup

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = t('.success_signup')
      redirect_to root_url
    else
      flash.now[:info] = t('.failed_signup')
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def prevent_current_user_from_signup
      if current_user
        flash[:warning] = t('users.prevent_signup')
        redirect_to root_url
      end
    end
end
