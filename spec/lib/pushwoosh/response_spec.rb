require "spec_helper"
require 'ostruct'

describe Pushwoosh::Response do
  let(:code) { 200 }
  let(:message) { 'OK' }
  let(:body) { 'null' }

  let(:client_response) do
    class FakeResponse < OpenStruct
      def body
        {
          status_code: status_code,
          status_message: status_message,
          response: response
        }.to_json
      end

      def [](arg)
        self.send(arg)
      end
    end

    FakeResponse.new(
      status_code: code,
      status_message: message,
      response: nil
    )
  end

  subject { described_class.new(client_response) }

  describe '#code' do
    it 'returns 200' do
      expect(subject.code).to eq 200
    end
  end

  describe '#message' do
    it 'has the correct message' do
      expect(subject.message).to eq 'OK'
    end
  end

  describe '#body' do
    it 'has the correct message' do
      expect(subject.body).to eq nil
    end
  end

  describe '#to_s' do
    describe 'the format' do
      it 'has the correct code' do
        expect(subject.to_s).to match /#{code}/
      end

      it 'has the correct message' do
        expect(subject.to_s).to match /#{message}/
      end
    end
  end

  describe '#inspect' do
    describe 'the format' do
      it 'has the object class name' do
        expect(subject.inspect).to match /#{subject.class.to_s}/
      end

      it 'wraps the content in angular brackets' do
        expect(subject.inspect).to match /\A</
        expect(subject.inspect).to match />\z/
      end

      it 'has the correct code' do
        expect(subject.inspect).to match /#{code}/
      end

      it 'has the correct message' do
        expect(subject.inspect).to match /#{message}/
      end
    end
  end
end
