require "vodem_sms/message"

module VodemSms
  class Messages
    include VodemSms::Headers

    def get_message
      response = Typhoeus.get(
        WEBSERVER_GET_CMD_URL,
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
