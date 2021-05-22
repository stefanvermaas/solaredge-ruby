# frozen_string_literal: true

module Solaredge
  class Configuration
    # The `api_key` can either be the Site API key or the Account API key.
    # @return [String] The API key for accessing the Solaredge API
    attr_accessor :api_key

    # The `response_format` enables API consumers to define a custom response format.
    # @return [Symbol] The response format for the API response.
    AVAILABLE_RESPONSE_FORMATS = %i[json xml csv].freeze
    attr_reader :response_format

    def initialize
      @api_key = ""
      @response_format = :json
    end

    # The `response_format=` allows overwriting the response format for all API calls.
    # @param format [String, Symbol] The new response format
    # @return [Symbol] The response format
    def response_format=(format)
      new_response_format = format.downcase.to_sym
      raise InvalidResponseFormat, new_response_format unless AVAILABLE_RESPONSE_FORMATS.include?(new_response_format)

      @response_format = new_response_format
    end
  end

  # Returns Solaredge's configuration.
  # @return [Solaredge::Configuration] Solaredge's configuration
  def self.config
    @config ||= Configuration.new
  end

  # Allows setting a new configuration for Solaredge.
  # @return [Solaredge::Configuration] Solaredge's new configuration
  def self.config=(configuration)
    raise BadConfiguration unless configuration.is_a?(Configuration)

    @config = configuration
  end

  # Allows modifying Solaredge's configuration.
  #
  # Example usage:
  #
  #   Solaredge.configure do |config|
  #     config.api_key = "..."
  #   end
  #
  def self.configure
    yield(config)
  end
end
