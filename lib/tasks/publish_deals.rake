task :publish_deals => :environment do
  schedule_deal
  unpublish_old_deal
end

def schedule_deal
  @deals = Deal.where(publish_date: Date.today, state: :publishable)
  @deals.each do |deal|
      deal.set_deal_published
  end
  # puts "scheduled deal  at 10 am running for 24 hours"
end


def unpublish_old_deal
  @deals = Deal.where(publish_date: Date.today - 1, state: :published)
  @deals.each do |deal|
    deal.set_deal_over
  end
end
