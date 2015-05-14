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

      expect(step._to).to eq('+18555555555')
      expect(step._from).to eq('+18555555556')
      expect(step._body).to eq('use code 3:16 for high leniency')
    end

  end

  describe '#run' do

    it 'should return a the value of the block' do
      step = Pushpop::Twilio.new do |response|
        to '+18555555555'
        from '+18555555556'
        body "The response is #{response}"

        'test'
      end

      step.configure
      allow(step).to receive(:send_message).with('+18555555555', '+18555555556', 'The response is 365')
      expect(step.run(365)).to eq('test')
    end

    it 'should send a message' do

      step = Pushpop::Twilio.new do |response|
        to '+18555555555'
        from '+18555555556'
        body "The response is #{response}"
      end
      step.configure
      allow(step).to receive(:send_message).with('+18555555555', '+18555555556', 'The response is 365').and_return(5)
      expect(step.run(365)).to eq(5)

    end

    it 'should not send a message if body not specified' do
      step = Pushpop::Twilio.new do
        to '+18555555555'
        from '+18555555556'
      end
      step.configure
      allow(step).to receive(:send_message).and_return(5)
      expect {
        step.run(365)
      }.to raise_error /Please configure/
    end

    it 'should not send a message if to not specified' do
      step = Pushpop::Twilio.new do |response|
        from '+18555555556'
        body "The response is #{response}"
      end
      step.configure
      allow(step).to receive(:send_message).and_return(5)
      expect {
        step.run(365)
      }.to raise_error /Please configure/

    end

    it 'should not send a message if from not specified' do
      step = Pushpop::Twilio.new do |response|
        to '+18555555556'
        body "The response is #{response}"
      end
      step.configure
      allow(step).to receive(:send_message).and_return(5)
      expect {
        step.run(365)
      }.to raise_error /Please configure/
    end

  end

end
