require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VeteransWork
  class Application < Rails::Application
    config.generators do |g|
      g.fixture_replacement :factory_girl
    end
    config.time_zone = "Central Time (US & Canada)"
  end
end

unless Rails.env.test?
  Raven.configure do |config|
    config.dsn = ENV["SENTRY_DSN"]
  end
end
