require 'pushpop'
require 'twilio-ruby'

TWILIO_SID = ENV['TWILIO_SID']
TWILIO_AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
TWILIO_FROM = ENV['TWILIO_FROM']

module Pushpop

  class Twilio < Step

    PLUGIN_NAME = 'twilio'

    Pushpop::Job.register_plugin(Twilio::PLUGIN_NAME, Twilio)

    attr_accessor :_from
    attr_accessor :_to
    attr_accessor :_body

    def run(last_response=nil, step_responses=nil)

      self.configure(last_response, step_responses)

      _to = self._to
      _from = self._from || TWILIO_FROM
      _body = self._body

      if _to && _from && _body
        send_message(_to, _from, _body)
      else
        raise 'Please configure to, from, and body to send an SMS'
      end
    end

    def send_message(to, from, body)
      client = ::Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH_TOKEN)
      client.account.messages.create(
          from: from,
          to: to,
          body: body )
    end

    def from(from)
      self._from = from
    end

    def to(to)
      self._to = to
    end

    def body(body)
      self._body = body
    end

    def configure(last_response=nil, step_responses=nil)
      self.instance_exec(last_response, step_responses, &block)
    end

  end

end
