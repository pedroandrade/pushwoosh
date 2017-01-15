module Pushwoosh
  class Response
    attr_reader :message, :body, :response_object
    attr_accessor :code

    alias_method :status_code, :code
    alias_method :status_message, :message
    alias_method :response, :body

    def initialize(parsed_response)
      @response = parsed_response
      @code = parsed_response['status_code']
      @message = parsed_response['status_message']
      @body = parsed_response['response']
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
      "<#{self.class.name}: #{params.inspect}>"
    end
  end
end
