require 'spec_helper'

describe Pushwoosh do
  before do
    Pushwoosh.configure do |config|
      config.application = '5555-5555'
      config.auth = 'abcdefghijklmnopq'
    end
  end

  it "send push message" do
    VCR.use_cassette 'pushwoosh/push_notification' do
      response = Pushwoosh::notify_all("Testing")
      expect(response.status_code).to eq 200
    end
  end

  it  'raises a error if message is empty' do
    VCR.use_cassette 'pushwoosh/empty_message_push' do
      lambda {Pushwoosh::notify_all("")}.should raise_error
    end
  end


end
