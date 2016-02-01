require 'spec_helper'

describe Pushwoosh do
  before do
    Pushwoosh.configure do |config|
      config.application = '5555-5555'
      config.auth = 'abcefg'
    end
  end

  describe '.notify_all' do
    context 'when has message' do
      it 'sends push message' do
        VCR.use_cassette 'pushwoosh/push_notification' do
          response = described_class.notify_all("Testing")
          expect(response.status_code).to eq 200
        end
      end
    end
  end
end
