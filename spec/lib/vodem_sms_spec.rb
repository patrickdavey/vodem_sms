require 'spec_helper'
require 'vodem_sms'

module VodemSms
  describe Vodem do
    context "disconnected status" do
      let(:vodem) { Vodem.new }

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(true)
      end
    end
  end
end
