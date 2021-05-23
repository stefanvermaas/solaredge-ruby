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
end
