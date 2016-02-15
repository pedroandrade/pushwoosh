module Pushwoosh
  class Response
    attr_reader :message, :body, :api_response
    attr_accessor :code

    alias_method :status_code, :code
    alias_method :status, :code
    alias_method :status_message, :message
    alias_method :response, :body

    def initialize(opts = {})
      @api_response = opts[:api_response]
      if @api_response
        parsed_response = JSON.parse @api_response.body
        @code  = parsed_response['status_code']
        @message  = parsed_response['status_message']
        @body  = parsed_response['response']
      else
        @code = opts[:status_code.to_s]
        @message = opts[:status_message.to_s]
        @body = opts[:response.to_s]
      end
    end

    def success?
      if /\A2\d\d\z/ === code.to_s
        true
      else
        false
      end
    end

    def params
      {
        code: code,
        message: message,
        body: body
      }
    end

    def to_s
      params.inspect
    end

    def inspect
      "<#{self.class.name}: #{params.merge(response: response.inspect).inspect}>"
    end
  end
end
