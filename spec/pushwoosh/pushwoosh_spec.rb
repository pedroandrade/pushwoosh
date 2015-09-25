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
          response = described_class.notify_all('Testing')
          expect(response.status_code).to eq 200
        end
      end
    end

    context 'when message is empty' do
      it 'send silent push if message is empty' do
        VCR.use_cassette 'pushwoosh/empty_message_push' do
          response = described_class.notify_all('')
          expect(response.status_code).to eq 200
        end
      end
    end

    context 'when message is nil' do
      it 'raises a error if message is nil' do
        VCR.use_cassette 'pushwoosh/nil_message_push' do
          expect { described_class.notify_all(nil) }.to raise_error
        end
      end
    end
  end
end
