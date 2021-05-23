# frozen_string_literal: true

require "net/http"
require "json"

module Solaredge
  # The `HttpClient` is a thin wrapper around the Net::HTTP::GET class with
  # some sensible defaults for the interaction with the Solaredge API.
  class HttpClient
    SOLAREDGE_API_ENDPOINT = "https://monitoringapi.solaredge.com"

    attr_reader :api_endpoint

    def initialize
      @api_endpoint = SOLAREDGE_API_ENDPOINT
    end

    # The `request` performs an HTTP GET request to the given path.
    # @param path [String] The path to the requested resource
    # @param params [Hash] A hash with additional parameters for the requested resource.
    # @return [String] the response from the API
    def request(path:, params: {})
      raise MissingApiKey if Solaredge.config.api_key.empty?

      # Build the full resource url based on the given path and the optional params.
      resource_url = build_resource_url(path, params)

      # Perform the HTTP request and return the response body.
      response = Net::HTTP.get_response(resource_url)
      response_body = JSON.parse(response.body)

      unless response.is_a?(Net::HTTPSuccess)
        raise HttpClientError.new(code: response.code, message: response_body["String"])
      end

      # Return the response body so it can be parsed by the `Solaredge::Resource`.
      response_body
    end

    private

    def build_resource_url(path, params = {})
      api_key = Solaredge.config.api_key

      URI("#{api_endpoint}/#{path}.json").tap do |url|
        url.query = URI.encode_www_form(params.merge(api_key: api_key))
      end
    end
  end

  # Returns the `Solaredge::HttpClient` to interact with the Solaredege monitoring API.
  # @return [Solaredge::HttpClient] The `Solaredge::HttpClient`
  def self.client
    @client ||= HttpClient.new
  end
end
