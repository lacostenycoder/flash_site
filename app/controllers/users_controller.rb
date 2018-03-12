class UsersController < ApplicationController
  before_action :redirect_when_logged_in
  before_action :find_user_by_confirm_token, only: :confirm_email

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('.success')
      redirect_to root_url
    else
      flash.now[:info] = t('.failure')
      render :new
    end
  end

  def confirm_email
    if @user && @user.activate_email
      flash[:success] = t('.success')
      redirect_to login_url
    else
      flash[:warning] = t('.failure')
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

    def find_user_by_confirm_token
      @user = User.find_by(confirm_token: params[:id])
    end
end
