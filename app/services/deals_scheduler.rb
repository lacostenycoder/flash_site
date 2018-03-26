class DealsScheduler
  def self.publish(date)
    @date = date || Date.current
    publish_todays_deals
    unpublish_old_deals
  end

  def self.publish_todays_deals
    @deals = Deal.published_on(@date).publishable
    @deals.each do |deal|
      deal.update_state(:published)
    end
  end

  def self.unpublish_old_deals
    @deals = Deal.published_on(@date- 1).published
    @deals.each do |deal|
      deal.update_state(:over)
    end
  end
end
