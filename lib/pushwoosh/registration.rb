module Pushwoosh
  class Registration
    attr_reader :auth, :application

    def initialize(auth_hash = {})
      unless auth_hash.respond_to?(:fetch)
        raise(ArgumentError,
              "Authentication details must be provided " +
              "as a hash: #{auth_hash.inspect}")
      end
      @auth = auth_hash.fetch(:auth, nil)
      @application = auth_hash.fetch(:application, nil)
      @auth_hash = { auth: @auth, application: @application }
    end

    def register(data = {})
      post_request(
        register_endpoint,
        wrap_request(register_data.merge(data))
      )
    end

    def unregister(hwid)
      data = { hwid: hwid }
      post_request(
        unregister_endpoint,
        wrap_request(data)
      )
    end

    private

    def wrap_request(data)
      {
        request: add_auth(data)
      }
    end

    def add_auth(data)
      data.merge(@auth_hash)
    end

    def post_request(endpoint, data)
      response = HTTParty.post(
        api_url(endpoint),
        {
          headers: {
            'Content-Type' => 'application/json'
          },
          body: data.to_json
        }
      )

      our_response = Response.new(response)

      standarize_status_code(our_response)
    end

    def standarize_status_code(response)
      if response.code == 210
        case response.message
        when "Application not found"
          response.code = 401
        when /\AAPI token or application/
          response.code = 401
        else
          response.code = 400
        end
      end

      response
    end

    def api_url(endpoint)
      base_url + endpoint
    end

    def register_data_keys
      [:hwid, :device_type, :push_token, :timezone]
    end

    def register_data
      Hash[register_data_keys.map { |k| [ k, "" ] }]
    end

    def register_endpoint
      "/registerDevice"
    end

    def unregister_endpoint
      "/unregisterDevice"
    end

    def base_url
      "https://cp.pushwoosh.com/json/1.3"
    end
  end
end
