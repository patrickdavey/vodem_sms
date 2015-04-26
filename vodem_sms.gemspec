# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vodem_sms/version'

Gem::Specification.new do |spec|
  spec.name          = "vodem_sms"
  spec.version       = VodemSms::VERSION
  spec.authors       = ["Patrick Davey"]
  spec.email         = ["patrick.davey@gmail.com"]

  spec.summary       = %q{Some helper commands for use with a vodafone modem.}
  spec.description   = %q{Adds the ability to get the status and bring a connection up and down.}
  spec.homepage      = "https://github.com/patrickdavey/vodem_sms"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", ">= 0.9.12"
  spec.add_development_dependency "rspec-its", "~> 1.1.0"
  spec.add_development_dependency "webmock", "~> 1.2"
  spec.add_development_dependency "rspec-html-matchers", "~> 0.6.1"
  spec.add_development_dependency "guard-rspec", "~> 4.3"
  spec.add_runtime_dependency     "typhoeus", "~> 0.7.1"
end
