class UsersController < ApplicationController

  before_action :redirect_when_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now!
      flash[:success] = t('.success_signup')
      redirect_to root_url
    else
      flash.now[:info] = t('.failed_signup')
      render :new
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      user.email_activate
      flash[:success] = t('.email_confirm_success')
      redirect_to login_url
    else
      flash[:error] = t('.email_confirm_fail')
      redirect_to root_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def redirect_when_logged_in
      if current_user
        flash[:warning] = t('users.prevent_signup')
        redirect_to root_url
      end
    end
end
