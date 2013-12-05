require 'spec_helper'

describe Pushwoosh::Helpers do

  it 'shoud cut a string with 256 bytes' do
    string_to_be_cuted = "é" * 300
    cuted_string = Pushwoosh::Helpers::limit_string(string_to_be_cuted, 256)
    expect(cuted_string.size).to eq 128
  end
end
