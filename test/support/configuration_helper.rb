# frozen_string_literal: true

# Allows temporary setting a configuration option during tests. Switches back
# to the original configuration after running the test.
def with_solaredge_config(&block)
  previous_config = Solaredge.config
  Solaredge.configure { |config| block.call(config) }
ensure
  Solaredge.config = previous_config
end
