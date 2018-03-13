class UserPresenter
  def initialize user
    @user = user
  end

  def fullname
    @user.first_name + " " + @user.last_name
  end
end
