class SubscriptionMailerJob < ActiveJob::Base
  queue_as :default

  def perform(subscription_id, quote)
    subscription = Subscription.find(subscription_id)
    SubscriptionMailer.post(subscription, quote).deliver
    subscription.update(last_delivered_at: Time.zone.now)
  rescue ActiveRecord::RecordNotFound
    # fail silently
    # This record has been deleted, so no need to retry
    Rails.logger.error "Trying to send email to deleted record. Discarding."
  end
end
