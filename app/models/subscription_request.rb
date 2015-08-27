class SubscriptionRequest < ActiveRecord::Base
  validates :email, presence: true

  before_create do
    self.token = SecureRandom.urlsafe_base64(32)
    self.valid_until = 1.day.from_now
  end
end
