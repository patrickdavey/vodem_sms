require 'spec_helper'
require 'vodem_sms'

module VodemSms
  describe Vodem do
    let(:vodem) { Vodem.new }
    context "disconnected status" do
      before do
        return_disconnected_response
      end

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(true)
        expect(vodem.connected?).to be(false)
        expect(vodem.connecting?).to be(false)
      end
    end

    context "connected status" do
      before do
        return_connected_response
      end

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(false)
        expect(vodem.connected?).to be(true)
        expect(vodem.connecting?).to be(false)
      end
    end

    context "connecting status" do
      before do
        return_connecting_response
      end

      it "must correctly setup the connection status" do
        expect(vodem.disconnected?).to be(false)
        expect(vodem.connected?).to be(false)
        expect(vodem.connecting?).to be(true)
      end
    end

    context "commands" do
      it "if already connected should not try to reconnect" do
        return_connected_response

        expect(vodem.connected?).to be(true)
        expect(vodem.connect!).to be_a(VodemSms::StatusChecker::Status)
      end

      it "must be able to issue a connect command" do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return(
            { body: '{"ppp_status": "ppp_disconnected"}' }, # for the first connected call
            { body: '{"ppp_status": "ppp_connected"}' })

        stub_connect_command
        vodem.connect!
        expect(vodem.connected?).to be(true)
      end

      it "must be able to issue a disconnect command" do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return({ body: '{"ppp_status": "ppp_connected"}' },
                                 { body: '{"ppp_status": "ppp_disconnected"}' })

        stub_disconnect_command
        expect(vodem.connected?).to be(true)
        vodem.disconnect!
        expect(vodem.connected?).to be(false)
      end
    end

    describe "messages" do
      it "must return an array containing the latest message, or an empty array" do
        stub_message_command

        latest_message = vodem.latest_message
        expect(latest_message).to be_a(VodemSms::Messages::Message)
        expect(latest_message.from).to eq("+64211632139")
        expect(latest_message.content).to eq("Testing")
      end
    end
  end
end
