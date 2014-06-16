# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'pushpop-twilio/version'

Gem::Specification.new do |s|

  s.name        = "pushpop-twilio"
  s.version     = Pushpop::Twilio::VERSION
  s.authors     = ["Josh Dzielak"]
  s.email       = "josh@keen.io"
  s.homepage    = "https://github.com/pushpop-project/pushpop-twilio"
  s.summary     = "Twilio plugin for sending SMS messages from Pushpop"

  s.add_dependency "pushpop"
  s.add_dependency "twilio-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

