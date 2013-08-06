require 'forwardable'

module Pushwoosh
  module Configurable
    extend Forwardable

    attr_writer :application, :auth
    attr_accessor :application, :auth

    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :application,
          :auth,
        ]
      end

    end

    def configure
      yield self
      validate_credential_type!
      self
    end

  private

    # @return [Hash]
    def credentials
      {
        application: @application,
        auth:        @auth
      }
    end

    # @return [Hash]
    def options
      Hash[Pushwoosh::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    def validate_credential_type!
      credentials.each do |credential, value|
        next if value.nil?

        unless value.is_a?(String) || value.is_a?(Symbol)
          raise(Exception, "Invalid #{credential} specified: #{value} must be a string or symbol.")
        end
      end
    end

  end
end
