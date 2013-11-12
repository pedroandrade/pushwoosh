require "pushwoosh/version"
require 'pushwoosh/push_notification'
require 'pushwoosh/configurable'
require 'httparty'

module Pushwoosh
  class << self
    include Pushwoosh::Configurable

    def notify_all(message)
      puts options
      response = PushNotification.new(options).notify_all({content: message})
    end

    def notify_devices(message, devices = [])
      response = PushNotification.new(options).notify_devices(message, devices)
    end

  end
end
