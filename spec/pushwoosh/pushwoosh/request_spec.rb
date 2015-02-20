require 'spec_helper'

describe Pushwoosh::Request do

  describe '#make_post!' do
    let(:body) do
      {
        request:
        {
          application: "555555",
          auth: "5555-5555",
          notifications:
          [{
            send_date: "now",
            ios_badges: "+1",
            content: "Testing"
          }]
        }
      }
    end

    let(:options) do
      {
        auth: "5555-5555",
        application: "555555",
        notification_options:
        {
          send_date: "now",
          :ios_badges=>"+1",
          content: "Testing"
        }
      }
    end

    let(:response) do
      double(:response, response_hash)
    end

    let(:response_hash) do
      {
        status_code: 200,
        status_message: "OK",
        response: { "Messages" => ["555555534563456345"] }
      }
    end

    context 'when url is not empty' do
      subject { described_class.new('/createMessage', options) }

      it 'sends the notification with valid params' do
        allow(described_class).to receive(:post).with("/createMessage", body: body.to_json).and_return(response)
        allow(response).to receive(:parsed_response).and_return(OpenStruct.new(response_hash))
        response_of_make_post = subject.make_post!

        expect(response_of_make_post.status_code).to eq 200
        expect(response_of_make_post.status_message).to eq 'OK'
        expect(response_of_make_post.response['Messages']).to eq ['555555534563456345']
      end
    end
  end
end
