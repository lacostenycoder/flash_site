class LineItemsController < ApplicationController

  before_action :ensure_current_user, only: [:index, :create]
  before_action :ensure_state, only: :create

  def create
    @line_item = current_cart.line_items.build(line_item_params)
    if @line_item.save
      redirect_to root_url, flash: { success: t('.success') }
    else
      redirect_to root_url, flash: { warning: @line_item.errors[:base].to_sentence }
    end
  end

  def index
    @line_items = current_cart.line_items.includes(deal: :images)
  end

  private
    def line_item_params
      params.permit(:deal_id, :price)
    end

    def ensure_current_user
      unless current_user
        redirect_to root_url, flash: { warning: t('line_items.login_first') }
      end
    end

    def ensure_state
      current_cart.add_line_item if current_cart.address?
    end
end
