# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "solaredge"

require "minitest/autorun"

# Require additional helpers for the tests
require "support/configuration_helper"
