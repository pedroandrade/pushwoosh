require 'spec_helper'

describe Pushwoosh::Helpers do
  describe '.limit_string' do
    context 'when string is bigger than 256 bytes' do
      it 'returns the string with 256 bytes' do
        big_string = 'é' * 300
        expect(described_class.limit_string(big_string, 256).bytes.size).to eq 256
      end
    end
  end
end
