class Subscription < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  scope :eligible_for_delivery, ->(time) { where("last_sent_at IS NULL OR date(last_sent_at) < ?", time.to_date) }

  def self.publish!(time = Time.zone.now)
    delivered_ids = send_emails(time)
    where(id: delivered_ids).update_all(last_sent_at: time)
  end

  def self.send_emails(time = Time.zone.now)
    eligible_for_delivery(time).find_each.map do |subscription|
      SubscriptionMailer.post(subscription).deliver
      subscription.id
    end.compact
  end
end
