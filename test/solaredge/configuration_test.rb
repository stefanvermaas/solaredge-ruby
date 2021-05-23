# frozen_string_literal: true

require "test_helper"

describe Solaredge::Configuration do
  it "sets the api key to an empty string by default" do
    assert_equal "", Solaredge::Configuration.new.api_key
  end

  it "raises when the provided configuration object is not an instance of Solaredge::Configuration" do
    error_message = assert_raises Solaredge::BadConfiguration do
      Solaredge.config = Class.new
    end

    assert_equal(
      "[Solaredge] The provided configuration object is not a Solaredge::Configuration " \
        "instance. Please provide a Solaredge::Configuration instance when "  \
        "overriding the configuration directly.",
      error_message.to_s
    )
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
