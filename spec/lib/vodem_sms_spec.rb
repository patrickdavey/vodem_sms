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
      it "if already connected should not try to reconnect" do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return( body: '{"ppp_status": "ppp_connected"}')

        expect(vodem.connected?).to be(true)
        expect(vodem.connect!).to be_a(VodemSms::StatusChecker::Status)
      end

      it "must be able to issue a connect command" do
        stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
          to_return(
          { body: '{"ppp_status": "ppp_disconnected"}' }, # for the first connected call
                                 { body: '{"ppp_status": "ppp_connected"}' })

        stub_request(:post, "http://192.168.9.1/goform/goform_set_cmd_process").
         with(:body => "goformId=CONNECT_NETWORK").
         to_return(:status => 200, :body => "", :headers => {})

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

    describe "messages" do
      it "must return an array containing the latest message, or an empty array" do
       stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=sms_page_data&data_per_page=1&mem_store=1&order_by=order%2Bby%2Bid%2Bdesc&page=0&tags=12").
       and_return(status: 200, body: '{"messages":[{"id":"19","number":"+64211632139","content":"00540065007300740069006E0067","tag":"1","date":"15,04,26,20,32,54,+48","draft_group_id":""}]}')

        latest_message = vodem.latest_message
        expect(latest_message).to be_a(VodemSms::Messages::Message)
        expect(latest_message.from).to eq("+64211632139")
        expect(latest_message.content).to eq("Testing")
      end
    end
  end
end
