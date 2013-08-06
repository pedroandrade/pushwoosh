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
      response = Pushwoosh::notify_all("CDV")
      expect(response.status_code).to eq 200
    end
  end

  it  'return 210 if message is empty' do
    VCR.use_cassette 'pushwoosh/empty_message_push' do
      response = Pushwoosh::notify_all("{}")
      expect(response.status_code).to eq 210
    end
  end

end
