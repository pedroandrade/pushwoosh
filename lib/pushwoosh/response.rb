module Pushwoosh
  class Response

    attr_accessor :status_code, :status_message, :response

    def initialize(status_code, status_message, response)
      @status_code = status_code
      @status_message = status_message
      @response = response
    end
  end
end
