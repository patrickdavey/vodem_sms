require "vodem_sms/version"
require "typhoeus"
require "pry"
require "json"

module VodemSms
  class Vodem
    CONNECTED    = "ppp_connected"
    DISCONNECTED = "ppp_disconnected"
    CONNECTING   = "ppp_connecting"

    WEBSERVER_STATUS_URL    = "http://192.168.9.1/goform/goform_get_cmd_process"
    WEBSERVER_HOST_HEADER    = "192.168.9.1"
    AGENT_HEADER = "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0'" 
    LANGUAGE_HEADER= "en-US,en;q=0.5"
    ENCODING_HEADER = 'gzip, deflate'
    X_REQUESTED_WITH_HEADER = 'XMLHttpRequest'
    REFERRER_HEADER = 'http://192.168.9.1/home.htm'
    STATUS_FIELD = 'ppp_status'

    def initialize
      setup
    end

    def connected?
      current_status == CONNECTED
    end

    def disconnected?
      current_status == DISCONNECTED
    end

    def connecting?
      current_status == DISCONNECTED
    end


    private

    attr_reader :current_status

    def setup
      set_status
    end

    def set_status
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
      @current_status = JSON.parse(response.body)[STATUS_FIELD]
    end
  end
end
