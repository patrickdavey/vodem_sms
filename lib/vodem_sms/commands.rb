module VodemSms
  class Commands
    include VodemSms::Headers

    def connect!
      Typhoeus.post(
        WEBSERVER_SET_CMD_URL,
        headers: {
          Host: WEBSERVER_HOST_HEADER,
          "User-Agent" => AGENT_HEADER,
          "Accept-Language" => LANGUAGE_HEADER,
          "Accept-Encoding" => ENCODING_HEADER,
          "Cache-Control" => CACHE_CONTROL_HEADER,
          "Pragma" => PRAGMA_HEADER,
          "x-requested-with" => X_REQUESTED_WITH_HEADER,
          "Referer" => REFERRER_HEADER,
          Accept: "application/json"
        },
        body: {goformId: "CONNECT_NETWORK"},
      )
      sleep 10
    end

    def delete_message(id)
      Typhoeus.post(
        WEBSERVER_SET_CMD_URL,
        headers: {
          Host: WEBSERVER_HOST_HEADER,
          "User-Agent" => AGENT_HEADER,
          "Accept-Language" => LANGUAGE_HEADER,
          "Accept-Encoding" => ENCODING_HEADER,
          "Cache-Control" => CACHE_CONTROL_HEADER,
          "Content-Type" => CONTENT_TYPE_HEADER,
          "Pragma" => PRAGMA_HEADER,
          "x-requested-with" => X_REQUESTED_WITH_HEADER,
          "Referer" => REFERRER_HEADER,
          Accept: "application/json"
        },
        body: {
          goformId: "DELETE_SMS",
          msg_id: id
          }
      )
    end

    def disconnect!
      Typhoeus.post(
        WEBSERVER_SET_CMD_URL,
        headers: {
          Host: WEBSERVER_HOST_HEADER,
          "User-Agent" => AGENT_HEADER,
          "Accept-Language" => LANGUAGE_HEADER,
          "Accept-Encoding" => ENCODING_HEADER,
          "Cache-Control" => CACHE_CONTROL_HEADER,
          "Pragma" => PRAGMA_HEADER,
          "x-requested-with" => X_REQUESTED_WITH_HEADER,
          "Referer" => REFERRER_HEADER,
          Accept: "application/json"
        },
        body: {goformId: "DISCONNECT_NETWORK"},
      )

      sleep 2
    end
  end
end
