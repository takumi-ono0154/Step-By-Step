source "https://rubygems.org"

gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "net-pop", "~> 0.1.2"
gem "devise"
gem "msgpack", "~> 1.7"
gem "line-bot-api"
gem "simple_calendar"
gem "rails-i18n"
gem "omniauth-line"
gem "omniauth-rails_csrf_protection"
gem "dotenv-rails"
gem "meta-tags"
gem "sidekiq"
gem "sidekiq-cron"
gem "redis"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", "~> 6.2.2", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "letter_opener_web", "~> 3.0"
  gem "dockerfile-rails", ">= 1.6"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
