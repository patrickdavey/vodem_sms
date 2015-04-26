module WebmockHelpers
  def return_disconnected_response
    stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
      to_return(status: 200, body: '{"ppp_status": "ppp_disconnected"}')
  end

  def return_connected_response
    stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
      to_return(status: 200, body: '{"ppp_status": "ppp_connected"}')
  end

  def return_connecting_response
    stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=ppp_status").
      to_return(status: 200, body: '{"ppp_status": "ppp_connecting"}')
  end

  def stub_connect_command
    stub_request(:post, "http://192.168.9.1/goform/goform_set_cmd_process").
     with(:body => "goformId=CONNECT_NETWORK").
     to_return(:status => 200, :body => "", :headers => {})
  end

  def stub_disconnect_command
    stub_request(:post, "http://192.168.9.1/goform/goform_set_cmd_process").
     with(:body => "goformId=DISCONNECT_NETWORK").
     to_return(:status => 200, :body => "", :headers => {})
  end

  def stub_message_command
     stub_request(:get, "http://192.168.9.1/goform/goform_get_cmd_process?cmd=sms_page_data&data_per_page=1&mem_store=1&order_by=order%2Bby%2Bid%2Bdesc&page=0&tags=12").
     and_return(status: 200, body: '{"messages":[{"id":"19","number":"+64211632139","content":"00540065007300740069006E0067","tag":"1","date":"15,04,26,20,32,54,+48","draft_group_id":""}]}')
  end
end

RSpec.configure do |config|
  config.include WebmockHelpers
end
