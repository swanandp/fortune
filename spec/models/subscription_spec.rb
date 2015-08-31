require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "publish!" do
    before do
      create_subscriptions
      allow(Qotd).to receive(:get).and_return(FFaker::Lorem.paragraph(4))
    end

    it "sends out quotes to newly subscribed users" do
      expect { Subscription.publish! }
        .to change { ActionMailer::Base.deliveries.count }.by(10)
    end

    it "does not send out repeated emails" do
      Subscription.publish!

      expect { Subscription.publish! }
        .to_not change { ActionMailer::Base.deliveries.count }
    end

    it "does not send out repeated emails even with new subscriptions" do
      Subscription.publish!

      number_of_new_subscritions = 3
      number_of_new_subscritions.times { create(:subscription) }

      expect { Subscription.publish! }
        .to change { ActionMailer::Base.deliveries.count }.by(number_of_new_subscritions)
    end

    it "sends out new emails for a new date" do
      Subscription.publish!

      Timecop.travel(1.day.from_now) do
        expect { Subscription.publish! }
          .to change { ActionMailer::Base.deliveries.count }.by(10)

        expect(ActionMailer::Base.deliveries.count).to eq(20)
      end
    end
  end
end

def create_subscriptions
  10.times { create(:subscription) }
end
