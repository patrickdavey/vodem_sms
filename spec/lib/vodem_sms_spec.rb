require 'spec_helper'
require 'vodem_sms'

module VodemSms
  describe Vodem do
    context "disconnected status" do
      before do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return(status: 200, body: '{"ppp_status": "ppp_disconnected"}')
      end
      let(:vodem) { Vodem.new }

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(true)
        expect(vodem.connected?).to be(false)
        expect(vodem.connecting?).to be(false)
      end
    end

    context "connected status" do
      before do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return(status: 200, body: '{"ppp_status": "ppp_connected"}')
      end
      let(:vodem) { Vodem.new }

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(false)
        expect(vodem.connected?).to be(true)
        expect(vodem.connecting?).to be(false)
      end
    end

    context "connecting status" do
      before do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return(status: 200, body: '{"ppp_status": "ppp_connecting"}')
      end
      let(:vodem) { Vodem.new }

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(false)
        expect(vodem.connected?).to be(false)
        expect(vodem.connecting?).to be(true)
      end
    end
  end
end
