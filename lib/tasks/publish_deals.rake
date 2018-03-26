namespace :deals do
  desc "scheduler to publish new deals and unpublish old deals"
  task :publish => :environment do
    DealScheduler.publish
  end
end
