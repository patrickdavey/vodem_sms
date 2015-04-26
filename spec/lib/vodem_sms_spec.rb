require 'spec_helper'
require 'vodem_sms'

module VodemSms
  describe Vodem do
    let(:vodem) { Vodem.new }
    context "disconnected status" do
      before do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return(status: 200, body: '{"ppp_status": "ppp_disconnected"}')
      end

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

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(false)
        expect(vodem.connected?).to be(false)
        expect(vodem.connecting?).to be(true)
      end
    end

    context "commands" do
      it "must be able to issue a connect command" do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return({ body: '{"ppp_status": "ppp_disconnected"}' },
                                 { body: '{"ppp_status": "ppp_connected"}' })

        stub_request(:post, "http://192.168.9.1/goform/goform_set_cmd_process").
         with(:body => "goformId=CONNECT_NETWORK").
         to_return(:status => 200, :body => "", :headers => {})

        expect(vodem.connected?).to be(false)
        vodem.connect!
        expect(vodem.connected?).to be(true)
      end

      it "must be able to issue a disconnect command" do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return({ body: '{"ppp_status": "ppp_connected"}' },
                                 { body: '{"ppp_status": "ppp_disconnected"}' })
        stub_request(:post, "http://192.168.9.1/goform/goform_set_cmd_process").
         with(:body => "goformId=DISCONNECT_NETWORK").
         to_return(:status => 200, :body => "", :headers => {})

        expect(vodem.connected?).to be(true)
        vodem.disconnect!
        expect(vodem.connected?).to be(false)
      end
    end
  end
end
