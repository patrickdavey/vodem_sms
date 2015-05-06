# VodemSms
[![Code Climate](https://codeclimate.com/github/patrickdavey/vodem_sms/badges/gpa.svg)](https://codeclimate.com/github/patrickdavey/vodem_sms)
Basic gem for interfacing with a Vodafone Dongle.  It's a huwaei one,
so might be useful for others too.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vodem_sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vodem_sms

## Usage

There are just a couple of commands at the moment, connect!, disconnect!.  Also status info.  Sample script:

```ruby
  require 'vodem_sms'

  vodem = Vodem.new

  vodem.connected?
  vodem.disconnected?
  vodem.connecting?

  vodem.connect! #connect to the 3G network
  vodem.disconnect! #disconnect from the 3G network

  # messages

  latest_message = vodem.latest_message

  message.from # mobile number it was sent from
  message.id # id of the mobile
  message.sent_at # DateTime timestamp of when it was sent
  message.content # the actual text of the message.

  message.delete! # delete the message off the modem

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/vodem_sms/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
