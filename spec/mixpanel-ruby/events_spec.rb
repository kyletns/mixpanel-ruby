require 'spec_helper'
require 'mixpanel-ruby/events.rb'

describe Mixpanel::Events do
  before(:each) do
    @log = []
    @events = Mixpanel::Events.new('TEST TOKEN') do |type, message|
      @log << [ type, JSON.load(message) ]
    end
  end

  it 'should send a well formed track/ message' do
    @events.track('TEST ID', 'Test Event', {
        'Circumstances' => 'During a test'
    })
    @log.should eq([[ :event, {
        'event' => 'Test Event',
        'properties' => {
            'Circumstances' => 'During a test',
            'distinct_id' => 'TEST ID',
            'token' => 'TEST TOKEN'
        }
    }]])
  end
end
