class Subscription < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  scope :eligible_for_delivery, ->(time) { where("last_sent_at IS NULL OR date(last_sent_at) < ?", time.to_date) }

  def self.publish!(time = Time.zone.now)
    return unless eligible_for_delivery(time).count > 0
    quote = Qotd.get
    enqueued_subscription_ids = send_emails(quote, time)
    where(id: enqueued_subscription_ids).update_all(last_sent_at: time)
  end

  def self.send_emails(quote, time = Time.zone.now)
    eligible_for_delivery(time).find_each.map do |subscription|
      SubscriptionMailerJob.perform_later(subscription.id, quote)
      subscription.id
    end.compact
  end
end
