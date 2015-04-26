require "vodem_sms/version"
require "vodem_sms/status_checker"
require "vodem_sms/commands"
require "typhoeus"
require "pry"
require "json"

module VodemSms
  class Vodem
    extend Forwardable
    def_delegators :status, :connected?, :disconnected?, :connecting?
    def_delegators :commands, :disconnect!

    def connect!
      commands.connect! and return false if disconnected?
      status
    end


    private

    def status
      StatusChecker.new.get_status
    end

    def commands
      Commands.new
    end
  end
end
