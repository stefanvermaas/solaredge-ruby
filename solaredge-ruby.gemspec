# frozen_string_literal: true

require_relative "lib/solaredge/version"

Gem::Specification.new do |spec|
  spec.name          = "solaredge-ruby"
  spec.version       = Solaredge::VERSION
  spec.authors       = ["Stefan Vermaas"]
  spec.email         = ["stefan@bobbiehq.com"]

  spec.summary       = "A Ruby Client library for interacting with the Solaredge Monitoring API"
  spec.homepage      = "https://www.github.com/stefanvermaas/solaredge-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
