require 'spec_helper'

describe Pushpop::Twilio do

  describe '#configure' do

    it 'should set various params' do

      step = Pushpop::Twilio.new do
        to '+18555555555'
        from '+18555555556'
        body 'use code 3:16 for high leniency'
      end

      step.configure

      step._to.should == '+18555555555'
      step._from.should == '+18555555556'
      step._body.should == 'use code 3:16 for high leniency'

    end

  end

  describe '#run' do

    it 'should send a message' do

      step = Pushpop::Twilio.new do |response|
        to '+18555555555'
        from '+18555555556'
        body "The response is #{response}"
      end
      step.configure
      step.stub(:send_message).with('+18555555555', '+18555555556', 'The response is 365').and_return(5)
      step.run(365).should == 5

    end

    it 'should not send a message if body not specified' do
      step = Pushpop::Twilio.new do
        to '+18555555555'
        from '+18555555556'
      end
      step.configure
      expect(step).not_to receive(:send_message)
      step.run(365)
    end

    it 'should not send a message if to not specified' do
      step = Pushpop::Twilio.new do |response|
        from '+18555555556'
        body "The response is #{response}"
      end
      step.configure
      expect(step).not_to receive(:send_message)
      step.run(365)
    end

    it 'should not send a message if from not specified' do
      step = Pushpop::Twilio.new do |response|
        to '+18555555556'
        body "The response is #{response}"
      end
      step.configure
      expect(step).not_to receive(:send_message)
      step.run(365)
    end

  end

end
