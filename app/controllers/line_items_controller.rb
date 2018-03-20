class LineItemsController < ApplicationController

  def create
    @line_item = current_cart.line_items.build(line_item_params)
    if @line_item.save
      flash[:success] = t('.success')
      redirect_to root_url
    else
      flash[:warning] = @line_item.errors[:base].to_sentence
      redirect_to root_url
    end
  end

  def index
    @line_items = current_cart.line_items.includes(deal: :images)
  end

  private
    def line_item_params
      params.permit(:deal_id, :price)
    end
end
