require "pushwoosh/version"
require 'pushwoosh/push_notification'
require 'pushwoosh/configurable'
require 'httparty'
require 'pushwoosh/helpers'

module Pushwoosh

  class << self
    include Pushwoosh::Configurable

    def notify_all(message, notification_options = {})
      response = PushNotification.new(options).notify_all(message, notification_options)
    end

    def notify_devices(message, devices = [], notification_options = {})
      response = PushNotification.new(options).notify_devices(message, devices, notification_options)
    end

  end
end
