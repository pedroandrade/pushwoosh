require 'httparty'
require 'json'
require 'pushwoosh/request'
require 'pushwoosh/response'
require 'pushwoosh/helpers'

module Pushwoosh
  class PushNotification
    class Error < StandardError; end;

    STRING_BYTE_LIMIT = 205 # recommended value, see https://community.pushwoosh.com/questions/286/why-am-i-receiving-a-payload-error for more details

    def initialize(options = {})
      @options = options
    end

    def notify_all(message, other_options = {})
      other_options.merge!(content: limited_content(message))
      create_message(other_options)
    end

    def notify_devices(message, devices, other_options = {})
      other_options.merge!(content: limited_content(message), devices: devices)
      create_message(other_options)
    end

    private

    attr_reader :options

    def limited_content(message)
      Helpers.limit_string(message, STRING_BYTE_LIMIT)
    end

    def create_message(notification_options = {})
      fail Error, 'Message is missing' if notification_options[:content].nil? || notification_options[:content].empty?

      Request.make_post!('/createMessage', build_notification_options(notification_options))
    end

    def build_notification_options(notification_options)
      { notification_options: default_notification_options.merge(notification_options) }.merge(options)
    end

    def default_notification_options
      {
        send_date: "now",
        ios_badges: "+1"
      }
    end
  end
end
