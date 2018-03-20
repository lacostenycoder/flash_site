class WelcomeController < ApplicationController
  def index
    @published_deals = Deal.published_deals
    @past_deals = Deal.past_deals.limit(2)
  end
end
