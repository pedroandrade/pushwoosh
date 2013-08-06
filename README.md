# Pushwoosh

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'pushwoosh'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pushwoosh

## Usage

Create a initializer in your application

config/initializers/pushwoosh.rb

Pushwoosh.configure do |config|
  config.application = '5555-5555'
  config.auth = 'abcdefghijklmnopq'
end

Notify all:

Pushwoosh.notify_all(message)

Notify some devices or a device:

Pushwoosh.notify_devices(message, devices)
NOTE: devices is an array

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
