require "rails_helper"

RSpec.describe Qotd, type: :model do
  context "complete failover" do
    before do
      allow_any_instance_of(Net::Telnet).to receive(:cmd).and_raise(Net::ReadTimeout)
    end

    it "fails over to next server when one server is not responsive" do
      expect { Qotd.get }.to raise_error { ArgumentError.new("No more servers left to try out. Please retry after some time.") }
    end
  end

  context "partial failover" do
    before do
      allow(Net::Telnet).to receive(:new).and_call_original
      allow(Net::Telnet).to receive(:new).with("Host" => "djxmmx.net", "Port" => 17).and_raise(Net::ReadTimeout)
    end

    it "fails for one server, but succeeds for others" do
      expect { Qotd.get }.to_not raise_error
    end
  end
end
