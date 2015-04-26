module VodemSms
  class StatusChecker
    include VodemSms::Headers

    STATUS_FIELD = 'ppp_status'

    class Status
      CONNECTED    = "ppp_connected"
      DISCONNECTED = "ppp_disconnected"
      CONNECTING   = "ppp_connecting"

      def initialize(status)
        @status = status
      end

      def connected?
        status == CONNECTED
      end

      def disconnected?
        status == DISCONNECTED
      end

      def connecting?
        status == CONNECTING
      end


      private

      attr_reader :status
    end

    def get_status
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
        timeout: 3,
        params: {cmd: "ppp_status"},
      )
      return Status.new(DISCONNECTED) unless response.success?

      Status.new(JSON.parse(response.body)[STATUS_FIELD])
    end
  end
end
