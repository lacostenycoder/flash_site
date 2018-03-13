class Admin::UsersController < Admin::BaseController
  def index
    render plain: 'ok'
  end
end
