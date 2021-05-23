# frozen_string_literal: true

module Solaredge
  class Error < StandardError; end

  # The `Solaredge::BadConfiguration` is raised whenever the newly provided
  # configuration is not a valid configuration object.
  class BadConfiguration < Error
    def initialize
      super(
        "[Solaredge] The provided configuration object is not a " \
          "Solaredge::Configuration instance. Please provide a "  \
          "Solaredge::Configuration instance when overriding the configuration directly."
      )
    end
  end

  # The `Solaredge::HttpClientError` is raised whenever the Solaredge API
  # returns a status code other than success.
  class HttpClientError < Error
    def initialize(code:, message:)
      super("[Solaredge] #{message}  - #{code}")
    end
  end

  # The `InvalidResponseFormat` is raised whenever the API consumer requested
  # a response format which is different from the available response formats.
  class InvalidResponseFormat < Error
    def initialize(response_format)
      super(
        "[Solaredge] '#{response_format}' is not a valid response format. " \
          "Please use one of the available response formats (e.g. json, xml or csv)."
      )
    end
  end

  # The `MissingApiKey` is raised whenever the API consumer forgot to add the API key.
  class MissingApiKey < Error
    def initialize
      super(
        "[Solaredge] Missing API key: Please, provide an API key to make requests " \
          "to the Solaredge Monitoring API."
      )
    end
  end
end
