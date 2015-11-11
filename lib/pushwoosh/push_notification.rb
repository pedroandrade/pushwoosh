require 'httparty'
require 'json'
require 'pushwoosh/exceptions'
require 'pushwoosh/request'
require 'pushwoosh/response'
require 'pushwoosh/helpers'

module Pushwoosh
  class PushNotification
    STRING_BYTE_LIMIT = 205 # recommended value, see https://community.pushwoosh.com/questions/286/why-am-i-receiving-a-payload-error for more details

    def initialize(auth_hash = {})
      @auth_hash = auth_hash
    end

    def notify_all(message, other_options = {})
      other_options.merge!(content: limited_content(message)) if message.present?

      create_message(other_options)
    end

    def notify_devices(message, devices, other_options = {})
      other_options.merge!(devices: devices)
      other_options.merge!(content: limited_content(message)) if message.present?

      create_message(other_options)
    end

    private

    attr_reader :auth_hash

    def limited_content(message)
      Helpers.limit_string(message, STRING_BYTE_LIMIT)
    end

    def create_message(notification_options = {})
      Request.make_post!('/createMessage', build_notification_options(notification_options))
    end

    def build_notification_options(notification_options)
      { notification_options: default_notification_options.merge(notification_options) }.merge(auth_hash)
    end

    def default_notification_options
      {
        send_date: 'now',
        ios_badges: '+1'
      }
    end
  end
end
