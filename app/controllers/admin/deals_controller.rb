class Admin::DealsController < Admin::BaseController
  def index
    @deals = Deal.all
  end

  def new
    @deal= Deal.new
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.created_by = current_user.id
    if @deal.save
      flash[:success] = t('.success')
      redirect_to admin_deals_url
    else
      flash.now[:warning] = t('.failure')
      render :new
    end
  end

  def update
    @deal = Deal.find(params[:id])
    if @deal.update(deal_params)
      flash[:success] = t('.success')
      redirect_to admin_deals_url
    else
      flash.now[:warning] = @deal.errors[:base]
      render :edit
    end
  end

  def destroy
    @deal = Deal.find(params[:id])
    if @deal.destroy
      flash[:success] = t(".destroyed")
      redirect_to admin_deals_url
    end
  end

  private
    def deal_params
      params.require(:deal).permit(:title, :description, :price, :discounted_price, :quantity, :publish_date, images_attributes: [:id, :attachment, :_destroy])
    end
end
