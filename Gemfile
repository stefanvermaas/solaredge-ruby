# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gemspec

group :development do
  gem "minitest", "~> 5.0"
  gem "rake", "~> 13.0"
  gem "rubocop", "~> 1.0"
  gem "rubocop-minitest", "~> 0.11"
  gem "rubocop-rake", "~> 0.5"
end

group :test do
  gem "webmock"
end
