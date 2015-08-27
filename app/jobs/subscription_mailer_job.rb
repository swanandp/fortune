class SubscriptionMailerJob < ActiveJob::Base
  queue_as :default

  def perform(subscription_request_id)
    subscription_request = SubscriptionRequest.find(subscription_request_id)
    SubscriptionRequestMailer.confirmation(subscription_request).deliver
  end
end
