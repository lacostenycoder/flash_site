class SessionsController < ApplicationController
  before_action :redirect_when_logged_in, only: [:new, :create]
  before_action :find_user, only: :create

  def new
  end

  def create
    if @user && @user.authenticate(params[:password])
      unless @user.confirm_token
        if params[:remember_me]
          cookies.permanent.signed[:user_id] = @user.id
        end
        flash[:success] = t('.success')
        session[:user_id] = @user.id
        redirect_to root_url
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
    flash[:success] = t('.logged_out')
    redirect_to root_url
  end

  private
    def redirect_when_logged_in
      if current_user
        flash[:warning] = t('sessions.prevent_login')
        redirect_to root_url
      end
    end

    def find_user
      @user = User.find_by(email: params[:email])
    end
end
