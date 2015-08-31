desc "Publish the latest edition of the psuedo-random newsletter"
task publish: :environment do
  Subscription.publish!
end
