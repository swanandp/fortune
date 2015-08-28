class SubscriptionRequest < ActiveRecord::Base
  validates :email, presence: true

  before_create do
    self.token = SecureRandom.urlsafe_base64(32)
  end

  def confirm!
    Subscription.create!(email: self.email)
    self.destroy
  end
end
