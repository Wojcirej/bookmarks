# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookmarks
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators.system_tests = nil
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid
      generator.test_framework :rspec
      generator.fixture_replacement :factory_bot, suffix_factory: 'factory'
    end
  end
end
