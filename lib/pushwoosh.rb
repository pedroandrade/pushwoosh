require "pushwoosh/version"
require 'pushwoosh/push_notification'
require 'pushwoosh/configurable'
require 'httparty'
require 'active_support/all'
require 'pushwoosh/helpers'

module Pushwoosh
  class << self
    include Pushwoosh::Configurable

    def notify_all(message)
      response = PushNotification.new(options).notify_all(message)
    end

    def notify_devices(message, devices = [])
      response = PushNotification.new(options).notify_devices(message, devices)
    end

  end
end
