class SubscriptionRequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription_request_mailer.confirmation.subject
  #
  def confirmation(subscription_request)
    @greeting = "Hello, there!"
    @token = subscription_request.token

    mail to: subscription_request.email, subject: "Please confirm your subscription for Fortune Cookie"
  end
end
