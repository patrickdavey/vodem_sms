require "vodem_sms/message"

module VodemSms
  class Messages
    WEBSERVER_GET_MESSAGE_URL    = "http://192.168.9.1/goform/goform_get_cmd_process"
    WEBSERVER_HOST_HEADER    = "192.168.9.1"
    AGENT_HEADER = "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0'" 
    LANGUAGE_HEADER= "en-US,en;q=0.5"
    ENCODING_HEADER = 'gzip, deflate'
    CACHE_CONTROL_HEADER = 'no-cache'
    CONNECTION_HEADER = 'keep-alive'
    CONTENT_TYPE_HEADER = 'application/x-www-form-urlencoded; charset=UTF-8'
    PRAGMA_HEADER = 'no-cache'
    X_REQUESTED_WITH_HEADER = 'XMLHttpRequest'
    REFERRER_HEADER = 'http://192.168.9.1/home.htm'

    def get_message
      response = Typhoeus.get(
        WEBSERVER_GET_MESSAGE_URL,
        headers: {
          Host: WEBSERVER_HOST_HEADER,
          "User-Agent" => AGENT_HEADER,
          "Accept-Language" => LANGUAGE_HEADER,
          "Accept-Encoding" => ENCODING_HEADER,
          "x-requested-with" => X_REQUESTED_WITH_HEADER,
          "Referer" => REFERRER_HEADER,
          Accept: "application/json"
        },
        params: {cmd: "sms_page_data",page: 0, data_per_page: 1, mem_store: 1, tags:12,
          order_by: "order+by+id+desc"},
      )
      messages = JSON.parse(response.body)["messages"]
      if messages.empty?
        nil
      else
        Message.new(messages.first)
      end
    end
  end
end
