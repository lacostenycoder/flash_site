class CustomersController < UsersController

  def new
    @user = Customer.new
  end

  def create
    @user = Customer.new(customer_params)
    if @user.save
      flash[:success] = t('.success')
      redirect_to root_url
    else
      flash.now[:info] = t('.failure')
      render :new
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
