class SessionsController < ApplicationController

  before_action :redirect_when_logged_in, only: [:new, :create]
  before_action :find_user, only: :create

  def new
  end

  def create
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = t('.success_login')
      redirect_to root_url
    else
      flash.now[:warning] = t('.failed_login')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
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
