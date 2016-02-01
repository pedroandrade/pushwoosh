require 'spec_helper'

describe Pushwoosh::PushNotification do
  let(:options) do
    {
      auth: '5555-5555',
      application: '555555'
    }
  end

  let(:response) do
    double(:response, status_code: 200,
      status_message: "OK",
      response: {"Messages" => ["555555534563456345"]}
    )
  end

  subject { described_class.new(options) }

  describe '#notify_all' do
    let(:request) do
      {
        notification_options: {
          send_date: "now",
          content: "Testing"
        },
        auth: "5555-5555",
        application: "555555"
      }
    end

    context 'when message is not empty' do
      it 'sends the notification' do
        allow(Pushwoosh::Request).to receive(:make_post!).with("/createMessage", request).and_return(response)

        response_of_notify = subject.notify_all('Testing')

        expect(response_of_notify.status_code).to eq 200
        expect(response_of_notify.status_message).to eq 'OK'
        expect(response_of_notify.response['Messages']).to eq ['555555534563456345']
      end
    end
  end

  describe '#notify_devices' do
    let(:devices) do
      ['dec301908b9ba8df85e57a58e40f96f523f4c2068674f5fe2ba25cdc250a2a41',
        'bec301908b9ba8df85e57a58e40f96f523f4c2068674f5fe2ba25cdc250a2a41']
    end

    let(:request) do
      {
        notification_options: {
          send_date:  "now",
          content:    "Testing",
          devices: ["dec301908b9ba8df85e57a58e40f96f523f4c2068674f5fe2ba25cdc250a2a41",
                    'bec301908b9ba8df85e57a58e40f96f523f4c2068674f5fe2ba25cdc250a2a41']
        },
        auth: "5555-5555",
        application: "555555"
      }
    end

    context 'when message is not empty' do
      it 'sends the notification for some devices' do
        allow(Pushwoosh::Request).to receive(:make_post!).with("/createMessage", request).and_return(response)

        response_of_notify = subject.notify_devices('Testing', devices)

        expect(response_of_notify.status_code).to eq 200
        expect(response_of_notify.status_message).to eq 'OK'
        expect(response_of_notify.response['Messages']).to eq ['555555534563456345']
      end
    end
  end
end
