class DealsScheduler
  def initialize(date)
    @date = date
    @present_deals = Deal.published_on(@date).publishable
    @old_deals = Deal.published_on(@date - 1).published
end

  def publish
    update_deals(@old_deals, :over)
    update_deals(@present_deals, :published)
  end

  def update_deals(deals, state)
    deals.each do |deal|
      deal.update_columns(state: state)
    end
  end

  def self.publish(date = Date.current)
    new(date).publish
  end
end
