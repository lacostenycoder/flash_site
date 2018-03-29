class DealsScheduler
  def initialize(date)
    @date = date
    @present_deals = Deal.published_on(@date).publishable
    @old_deals = Deal.published_on(@date.prev_day).published
end

  def publish
    unpublish_old_deals
    publish_deals
  end

  def unpublish_old_deals
    update_deals(@old_deals, :over)
  end

  def publish_deals
    update_deals(@present_deals, :published)
  end

  def update_deals(deals, state)
    deals.each do |deal|
      deal.update_state(state)
    end
  end

  def self.publish(date = Date.current)
    new(date).publish
  end
end
