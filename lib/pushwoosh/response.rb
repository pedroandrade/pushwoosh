module Pushwoosh
  class Response

    attr_accessor :status_code, :status_message, :response

    def initialize(pushwoosh_response = {})
      @status_code = pushwoosh_response[:status_code]
      @status_message = pushwoosh_response[:status_message]
      @response = pushwoosh_response[:response]
    end
  end
end
