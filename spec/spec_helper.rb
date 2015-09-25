require 'rubygems'
require 'bundler/setup'
require 'pushwoosh'
require 'vcr'
require 'webmock'
require 'json'

VCR.configure do |c|
  # the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
end

RSpec.configure do |_config|
  # some (optional) config her
end
