class Admin::DealsController < Admin::BaseController
  before_action :find_deal, only: [:edit, :update, :destroy]

  def index
    @deals = Deal.all
  end

  def new
    @deal  = Deal.new
  end

  def edit
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
    if @deal.update(deal_params)
      flash[:success] = t('.success')
      redirect_to admin_deals_url
    else
      flash.now[:warning] = @deal.errors[:base].to_sentence
      render :edit
    end

  end

  def destroy
    if @deal.destroy
      flash[:success] = t(".success")
      redirect_to admin_deals_url
    else
      flash[:warning] = t(".failure")
      render :index
    end
  end

  private
    def deal_params
        params.require(:deal).permit(:title, :description, :price, :discounted_price, :quantity, :publish_date, images_attributes: [:id, :attachment, :_destroy])
    end

    def find_deal
      @deal = Deal.find_by(id: params[:id])
    end
end
