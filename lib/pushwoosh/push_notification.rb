require 'httparty'
require 'json'
require 'pushwoosh/request'
require 'pushwoosh/response'
require 'active_support/core_ext/hash/indifferent_access'
require 'pushwoosh/helpers'

module Pushwoosh
  class PushNotification

    class Error < StandardError; end;

    STRING_BYTE_LIMIT = 256

    def initialize(options = {})
      fail 'Missing application' unless options[:application]
      fail 'Missing auth key' unless options[:auth]

      @base_request = {
        request: {
          application: options[:application],
          auth: options[:auth]
        }
      }
    end

    def notify_all(message, options= {})
      options.merge!(content: Helpers.limit_string(message, STRING_BYTE_LIMIT))
      create_message(options)
    end

    def notify_devices(message, devices, options = {})
      create_message(
        content: Helpers.limit_string(message, STRING_BYTE_LIMIT),
        devices: devices
      )
    end

    private

    def create_message(notification_options = {})
      fail Error, 'Message is missing' if notification_options[:content].empty?
      response = Request.post("/createMessage",
        body: build_request(notification_options).to_json)
     Response.new(response.parsed_response.with_indifferent_access)
    end

    def build_request(notification_options = {})
      {
        request: @base_request[:request].merge(notifications:
        [default_notification_options.merge(notification_options)])
      }
    end

    def default_notification_options
      {
        send_date: "now",
        ios_bagdes: "+1"
      }
    end
  end
end
