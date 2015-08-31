class SubscriptionMailer < ApplicationMailer
  def post(subscription, quote)
    @quote = quote

    mail to: subscription.email, subject: "Your periodic dose of psuedo-random quotes"
  end
end
