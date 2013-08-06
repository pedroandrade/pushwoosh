require 'httparty'
module Pushwoosh
  class Request
    include HTTParty
    base_uri 'https://cp.pushwoosh.com/json/1.3/'
    format :json
  end
end
