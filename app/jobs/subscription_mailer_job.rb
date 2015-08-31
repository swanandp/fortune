class SubscriptionMailerJob < ActiveJob::Base
  queue_as :default

  def perform(subscription_id, quote)
    subscription = Subscription.find(subscription_id)
    SubscriptionMailer.post(subscription, quote).deliver_now
    subscription.update(last_delivered_at: Time.zone.now)
  rescue ActiveRecord::RecordNotFound
    # fail silently
    # This record has been deleted, so no need to retry
    logger.error { "Trying to send email for a deleted record. Discarding." }
  end
end
