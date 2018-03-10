class UserMailerPresenter
  def initialize user, template
    @user = user
    @template = template
  end

  def fullname
    @template.content_tag :span, @user.first_name + " " + @user.last_name
  end

  def confirm_token
    @user.confirm_token
  end
end
