require "rails_helper"

RSpec.describe SubscriptionRequestMailer, type: :mailer do
  describe "confirmation" do
    let(:subscription_request) { create(:subscription_request) }
    let(:mail) { SubscriptionRequestMailer.confirmation(subscription_request) }

    it "renders the headers" do
      expect(mail.subject).to eq("Please confirm your subscription for Fortune Cookie")
      expect(mail.to).to eq([subscription_request.email])
      expect(mail.from).to eq(["fortune-cookie@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(confirm_subscription_request_url(subscription_request.token))
    end
  end
end
