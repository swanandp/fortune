# Preview all emails at http://localhost:3000/rails/mailers/subscription_request_mailer
class SubscriptionRequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/subscription_request_mailer/confirmation
  def confirmation
    SubscriptionRequestMailer.confirmation
  end

end
