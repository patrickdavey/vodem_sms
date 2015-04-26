require "vodem_sms/version"
require "vodem_sms/status_checker"
require "typhoeus"
require "pry"
require "json"

module VodemSms
  class Vodem
    CONNECTED    = "ppp_connected"
    DISCONNECTED = "ppp_disconnected"
    CONNECTING   = "ppp_connecting"

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
      current_status == CONNECTING
    end


    private

    attr_reader :current_status

    def setup
      set_status
    end

    def set_status
      @current_status ||= StatusChecker.new.get_status
    end
  end
end
