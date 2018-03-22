class SessionsController < ApplicationController
  before_action :redirect_when_logged_in, only: [:new, :create]
  before_action :find_user, only: :create

  def new
  end

  def create
    if @user && @user.authenticate(params[:password])
      unless @user.confirm_token
        set_cookie_and_session
        flash[:success] = t('.success')
        if current_user.admin?
          redirect_to admin_root_url
        else
          redirect_to root_url
        end
      else
        flash.now[:warning] = t('.email_activation_warning')
        render :new
      end
    else
      flash.now[:warning] = t('.failure')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :user_id
    redirect_to root_url, flash: { success: t('.logged_out') }
  end

  private
    def redirect_when_logged_in
      if current_user
        redirect_to root_url, flash: { warning: t('sessions.prevent_login') }
      end
    end

    def find_user
      @user = User.find_by(email: params[:email])
    end

    def set_cookie_and_session
      if params[:remember_me]
        cookies.permanent.signed[:user_id] = @user.id
      else
        session[:user_id] = @user.id
      end
    end
end
