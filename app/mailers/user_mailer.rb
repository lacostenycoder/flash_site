class UserMailer < ApplicationMailer
  def registration_mail(user_id)
    user = User.find_by(id: user_id)
    @user = UserMailerPresenter.new(user, view_context)
    mail to: user.email
  end
end
