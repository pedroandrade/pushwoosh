module Pushwoosh
  class PushNotification
    include HttParty

    def initialize(options = {})
      auth = { application: options[:auth],:auth: options[:auth_token]}
    end

    def notify_all(message)
      notify_devices({content: message})
    end

    def notify_devices(notification_options = {}, devices = {})
       #- Default options, uncomment :data or :devices if needed
       default_notification_options = {
                           # YYYY-MM-DD HH:mm  OR 'now'
                           send_date: "now",
                           # Object( language1: 'content1', language2: 'content2' ) OR string
                           content: {
                               fr: "Test",
                               en: "Test"
                           },
                           # JSON string or JSON object "custom": "json data"
                           #:data  => {
                           #    :custom_data  => value
                           #},
                           # omit this field (push notification will be delivered to all the devices for the application), or provide the list of devices IDs
                           devices: devices
                         }

       #- Merging with specific options
       final_notification_options = default_notification_options.merge(notification_options)

       #- Constructing the final call
       options = @auth.merge({notifications: [final_notification_options]})
       options = {request:options}
       #- Executing the POST API Call with HTTPARTY - :body => options.to_json allows us to send the json as an object instead of a string
       response = self.class.post("https://cp.pushwoosh.com/json/1.3/createMessage",  body: options.to_json,headers: { 'Content-Type' => 'application/json' })
     end
  end
end
