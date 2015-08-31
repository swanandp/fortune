class SubscriptionRequestMailer < ApplicationMailer
  def confirmation(subscription_request)
    @greeting = "Hello, there!"
    @token = subscription_request.token

    mail to: subscription_request.email, subject: "Please confirm your subscription for Fortune Cookie"
  end
end
