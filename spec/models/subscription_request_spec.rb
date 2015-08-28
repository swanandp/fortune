require "rails_helper"

RSpec.describe SubscriptionRequest, type: :model do
  describe "factory" do
    it "creates a valid object" do
      expect(create(:subscription_request)).to be_valid
    end
  end

  describe "confirm!" do
    let(:subscription_request) { create(:subscription_request) }

    it "creates a subscription object upon confirmation" do
      expect {
        subscription_request.confirm!
      }.to change {
             Subscription.where(email: subscription_request.email).count
           }.from(0).to(1)
    end

    it "deletes itself upon confirmation" do
      expect {
        subscription_request.confirm!
      }.to change {
             SubscriptionRequest.where(email: subscription_request.email).count
           }.by(-1)
    end
  end
end
