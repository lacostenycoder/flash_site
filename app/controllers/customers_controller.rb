class CustomersController < UsersController

  def new
    @user = Customer.new
  end

  def create
    @user = Customer.new(user_params)
    if @user.save
      flash[:success] = t('.success')
      redirect_to root_url
    else
      flash.now[:info] = t('.failure')
      render :new
    end
  end
end
