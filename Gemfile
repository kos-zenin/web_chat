# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "bcrypt", "~> 3.1.7"
gem "dotenv-rails", require: "dotenv/rails-now"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "redis", "~> 4.0"
gem "redis-rails", "~> 5.0", ">= 5.0.2"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

gem "slim-rails", "~> 3.2"

gem "sidekiq", "~> 6.1", ">= 6.1.1"
gem "sidekiq-cron", "~> 1.2"

gem "bootsnap", ">= 1.4.2", require: false

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot", "~> 5.1", ">= 5.1.1"
  gem "factory_bot_rails", "~> 5.1", ">= 5.1.1", require: false
  gem "ffaker", "~> 2.14"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.4"
  gem "rspec-rails", "~> 4.0.0"
  gem "rubocop", "~> 0.80.1"
  gem "rubocop-rails", "~> 2.5", require: false
end
