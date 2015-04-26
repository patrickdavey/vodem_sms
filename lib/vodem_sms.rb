require "vodem_sms/version"
require "vodem_sms/status_checker"
require "vodem_sms/commands"
require "vodem_sms/messages"
require "vodem_sms/errors"
require "typhoeus"
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

    def latest_message
      VodemSms::Messages.new.get_message
    end

    private

    def status
      StatusChecker.new.get_status
    end

    def commands
      Commands.new
    end

    def messanger
      Messages.new
    end
  end
end
