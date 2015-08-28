require "rails_helper"

RSpec.describe SubscriptionRequestsController, type: :controller do
  describe "POST #create" do
    context "invalid email" do
      let(:params) do
        { subscription_request: { email: nil } }
      end

      it "returns http unprocessable_entity" do
        post :create, params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "valid email" do
      let(:params) do
        { subscription_request: { email: FFaker::Internet.email } }
      end

      it "returns http redirect" do
        post :create, params
        expect(response).to have_http_status(:redirect)
      end
    end

    context "already subscribed email" do
      let(:subscription) { create(:subscription) }

      let(:params) do
        { subscription_request: { email: subscription.email } }
      end

      it "returns http redirect" do
        post :create, params
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
