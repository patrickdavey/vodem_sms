module VodemSms
  class StatusChecker
    WEBSERVER_STATUS_URL    = "http://192.168.9.1/goform/goform_get_cmd_process"
    WEBSERVER_HOST_HEADER    = "192.168.9.1"
    AGENT_HEADER = "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0'" 
    LANGUAGE_HEADER= "en-US,en;q=0.5"
    ENCODING_HEADER = 'gzip, deflate'
    X_REQUESTED_WITH_HEADER = 'XMLHttpRequest'
    REFERRER_HEADER = 'http://192.168.9.1/home.htm'
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
        WEBSERVER_STATUS_URL,
        headers: {
          Host: WEBSERVER_HOST_HEADER,
          "User-Agent" => AGENT_HEADER,
          "Accept-Language" => LANGUAGE_HEADER,
          "Accept-Encoding" => ENCODING_HEADER,
          "x-requested-with" => X_REQUESTED_WITH_HEADER,
          "Referer" => REFERRER_HEADER,
          Accept: "application/json"
        },
        params: {cmd: "ppp_status"},
      )
      Status.new(JSON.parse(response.body)[STATUS_FIELD])
    end
  end
end
