class SubscriptionRequestMailerJob < ActiveJob::Base
  queue_as :default

  def perform(subscription_request_id)
    subscription_request = SubscriptionRequest.find(subscription_request_id)
    SubscriptionRequestMailer.confirmation(subscription_request).deliver
  rescue ActiveRecord::RecordNotFound
    # fail silently
    # This record has been deleted, so no need to retry
    logger.error { "Trying to send email for a deleted record. Discarding." }
  end
end
