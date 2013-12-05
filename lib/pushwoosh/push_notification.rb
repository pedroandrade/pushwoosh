require 'httparty'
require 'json'
require 'pushwoosh/request'
require 'pushwoosh/response'

module Pushwoosh
  class PushNotification

    STRING_BYTE_LIMIT = 256

    def initialize(options = {})
      @auth = {application: options[:application], auth: options[:auth]}
    end

    def notify_all(message)
      create_message({content: Pushwoosh::Helpers::limit_string(message, STRING_BYTE_LIMIT)})
    end

    def notify_devices(message, devices)
      create_message({content: Pushwoosh::Helpers::limit_string(message, STRING_BYTE_LIMIT), devices: devices})
    end

    def create_message(notification_options = {})
     default_notification_options = {send_date: "now"}
     final_notification_options = default_notification_options.merge(notification_options)
     options = @auth.merge({notifications: [final_notification_options]})
     options = {request:options}
     response = Request.post("/createMessage",  body: options.to_json)
     Response.new(response.parsed_response['status_code'], response.parsed_response['status_message'], response.parsed_response['response'])
    end
  end
end
