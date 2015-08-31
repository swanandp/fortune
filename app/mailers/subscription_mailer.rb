class SubscriptionMailer < ApplicationMailer

  def post(subscription)
    @quote = FFaker::Lorem.phrase

    mail to: subscription.email, subject: "Your periodic dose of psuedo-random quotes"
  end
end
