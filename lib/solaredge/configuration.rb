# frozen_string_literal: true

module Solaredge
  class Configuration
    # The `api_key` can either be the Site API key or the Account API key.
    # @return [String] The API key for accessing the Solaredge API
    attr_accessor :api_key

    def initialize
      @api_key = ""
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
