require "vodem_sms/version"
require "vodem_sms/status_checker"
require "typhoeus"
require "pry"
require "json"
require "forwardable"

module VodemSms
  class Vodem
    extend Forwardable
    def_delegators :status, :connected?, :disconnected?, :connecting?

    def initialize
      setup
    end


    private

    attr_reader :status

    def setup
      set_status
    end

    def set_status
      @status ||= StatusChecker.new.get_status
    end
  end
end
