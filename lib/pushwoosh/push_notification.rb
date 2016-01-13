require 'httparty'
require 'json'
require 'pushwoosh/exceptions'
require 'pushwoosh/request'
require 'pushwoosh/response'
require 'pushwoosh/helpers'

module Pushwoosh
  class PushNotification

    def initialize(auth_hash = {})
      @auth_hash = auth_hash
    end

    def notify_all(message, other_options = {})
      other_options.merge!(content: message)
      create_message(other_options)
    end

    def notify_devices(message, devices, other_options = {})
      other_options.merge!(content: message, devices: devices)
      create_message(other_options)
    end

    private

    attr_reader :auth_hash

    def create_message(notification_options = {})
      fail Pushwoosh::Exceptions::Error, 'Message is missing' if notification_options[:content].nil? || notification_options[:content].empty?

      Request.make_post!('/createMessage', build_notification_options(notification_options))
    end

    def build_notification_options(notification_options)
      { notification_options: default_notification_options.merge(notification_options) }.merge(auth_hash)
    end

    def default_notification_options
      {
        send_date: "now",
        ios_badges: "+1"
      }
    end
  end
end
