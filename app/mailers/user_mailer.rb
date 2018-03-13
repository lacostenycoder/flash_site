class UserMailer < ApplicationMailer
  def registration_mail(user_id)
    @user = User.find_by(id: user_id)
    mail to: @user.email
  end

  def forgot_password(user_id)
    @user = User.find_by(id: user_id)
    mail to: @user.email
  end
end
