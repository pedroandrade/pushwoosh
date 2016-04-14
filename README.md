Pushwoosh
=========
[![Build Status](https://travis-ci.org/pedroandrade/pushwoosh.svg?branch=master)](https://travis-ci.org/pedroandrade/pushwoosh)
[![Code Climate](https://codeclimate.com/github/pedroandrade/pushwoosh/badges/gpa.svg)](https://codeclimate.com/github/pedroandrade/pushwoosh)
[![Test Coverage](https://codeclimate.com/github/pedroandrade/pushwoosh/badges/coverage.svg)](https://codeclimate.com/github/pedroandrade/pushwoosh)

This a simple wrapper to pushwoosh remote API

## Installation

Add this line to your application's Gemfile:

    gem 'pushwoosh'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pushwoosh

## Usage

### Notify all devices:
```
Pushwoosh::PushNotification.new(auth_hash).notify_all(message, other_options)
```

### Notify some devices or a device:
```
Pushwoosh::PushNotification.new(auth_hash).notify_devices(message, devices, other_options)
```

```auth_hash = { auth: '55555-5555', application: '1234zxcvb' }```

for ```other_options``` hash you can see the [https://www.pushwoosh.com/programming-push-notification/pushwoosh-push-notification-remote-api/#PushserviceAPI-Method-messages-create](http://) and you can choose any key you want

### If you're using Rails:

Create a initializer in your application

```
config/initializers/pushwoosh.rb
```
and put configs

```
Pushwoosh.configure do |config|
  config.application = '5555-5555'
  config.auth = 'abcdefghijklmnopq'
end
```

### Notify all devices:
```
Pushwoosh.notify_all(message, other_options)
```

### Notify some devices or a device:
```
Pushwoosh.notify_devices(message, devices, other_options)
```

*NOTE: devices is an array

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
