class DealsScheduler
  def publish_todays_deals
    @deals = Deal.published_on.publishable
    @deals.each do |deal|
      deal.update_state(:published)
    end
  end

  def unpublish_old_deals
    @deals = Deal.published_on(Date.today - 1).published
    @deals.each do |deal|
      deal.update_state(:over)
    end
  end
end
