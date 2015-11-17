## pushpop-twilio

Twilio plugin for [Pushpop](https://github.com/pushpop-project/pushpop).

### Installation

Add `pushpop-twilio` to your Gemfile:

``` ruby
gem 'pushpop-twilio'
```

or install it as a gem:

``` shell
$ gem install pushpop-twilio
```

### Usage

The `twilio` plugin provides a DSL to specify SMS recipient information as well as the message itself.

Here's an example:

``` ruby
require 'pushpop-twilio'

job 'send a text' do

  twilio do
    to    '+18005555555'
    body  'Quick, move your car!'
  end

end
```

The `twilio` plugin requires that the following environment variables are set:

+ `TWILIO_AUTH_TOKEN`
+ `TWILIO_SID`
+ `TWILIO_FROM`

##### Non-DSL Methods

If you need a lower level interface to Twilio functionality, use the `send_message` method exposed by the plugin directly. Here's an example:

``` ruby
require 'pushpop-twilio'

job 'send a few texts' do

  twilio do
    ['+18005555555','+18005555556'].each do |to_number|
      send_message(to_number, ENV['TWILIO_FROM'], 'Quick, move your car!')
    end
  end

end
```

### Contributing

Code and documentation issues and pull requests are welcome.
