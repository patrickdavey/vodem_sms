require "date"

module VodemSms
  class Messages
    class Message
      attr_reader :from, :id, :sent_at, :content

      def initialize(message)
        @id = message["id"]
        @from = message["number"]
        set_date(message["date"])
        set_content(message["content"])
      end


      private

      def set_date(date)
        @sent_at ||= if /\A(?<year>\d\d),(?<month>\d\d),(?<day>\d\d),(?<hour>\d\d),(?<minute>\d\d)/ =~ date
          adjusted_year = year.to_i + 2000
          DateTime.strptime("#{adjusted_year}-#{month}-#{day}T#{hour}:#{minute}", '%Y-%m-%dT%H:%M')
        else
          Time.now
        end
      end

      def set_content(encoded_content)
        @content ||= [encoded_content].pack('H*').force_encoding('utf-16be').encode('utf-8')
      end
    end
  end
end
