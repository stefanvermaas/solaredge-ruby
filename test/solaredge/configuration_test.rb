# frozen_string_literal: true

require "test_helper"

describe Solaredge::Configuration do
  it "sets the response format to json by default" do
    assert_equal :json, Solaredge::Configuration.new.response_format
  end

  it "sets the api key to an empty string by default" do
    assert_equal "", Solaredge::Configuration.new.api_key
  end

  it "raises when the provided configuration object is not an instance of Solaredge::Configuration" do
    error_message = assert_raises Solaredge::BadConfiguration do
      Solaredge.config = Class.new
    end

    assert_equal(
      "The provided configuration object is not a Solaredge::Configuration " \
        "instance. Please provide a Solaredge::Configuration instance when "  \
        "overriding the configuration directly.",
      error_message.to_s
    )
  end

  describe "configuring the response format" do
    it "configures the response format" do
      with_temp_config do |config|
        config.response_format = :xml
        assert_equal :xml, config.response_format
      end
    end

    it "configures the response format when it's an upcased string" do
      with_temp_config do |config|
        config.response_format = "JSON"
        assert_equal :json, config.response_format
      end
    end

    it "raises when the response format is invalid" do
      with_temp_config do |config|
        error_message = assert_raises Solaredge::InvalidResponseFormat do
          config.response_format = :jsonp
        end

        assert_equal(
          "'jsonp' is not a valid response format. " \
            "Please use one of the available response formats (e.g. json, xml or csv).",
          error_message.to_s
        )
      end
    end
  end

  private

  # Allows temporary setting a configuration option during tests. Switches back
  # to the original configuration after running the test.
  def with_temp_config(&block)
    previous_config = Solaredge.config
    Solaredge.configure { |config| block.call(config) }
  ensure
    Solaredge.config = previous_config
  end
end
