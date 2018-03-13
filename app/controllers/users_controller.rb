class UsersController < ApplicationController
  before_action :redirect_when_logged_in
  before_action :find_user_by_confirm_token, only: :confirm_email
  before_action :find_user_by_email, only: :send_reset_password_email
  before_action :find_user_by_reset_password_token, only: :reset_password
  before_action :find_user_by_id, only: :update_password

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

  def forgot_password
  end

  def send_reset_password_email
    if @user && @user.send_forgot_password_email
      flash[:success] = t('.email_instructions')
      redirect_to login_url
    else
      flash.now[:warning] = t('.no_email')
      render 'forgot_password'
    end
  end

  def reset_password
    if @user && @user.nullify_reset_password_token
      if @user.reset_password_link_expired?
        flash[:warning] = t('.password_link_expired')
        redirect_to  login_url
      else
        render 'reset_password'
      end
    else
      flash[:warning] = t('.user_not_recognised')
      redirect_to login_url
    end
  end

  def update_password
    if @user.update(user_params)
      flash[:success] = t('.success')
      redirect_to login_url
    else
      flash.now[:warning] = t('.failure')
      render 'reset_password'
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

    def find_user_by_id
      @user = User.find_by(id: params[:id])
    end

    def find_user_by_confirm_token
      @user = User.find_by(confirm_token: params[:id])
    end

    def find_user_by_email
      @user = User.find_by(email: params[:email])
    end

    def find_user_by_reset_password_token
      @user = User.find_by(reset_password_token: params[:id])
    end
end
