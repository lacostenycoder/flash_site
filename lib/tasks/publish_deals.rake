namespace :deals do
  desc "scheduler to publish new deals and unpublish old deals"
  task :publish => :environment do
    DealsScheduler.publish
  end
end
