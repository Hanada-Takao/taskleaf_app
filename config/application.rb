require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Taskleaf
  class Application < Rails::Application
    config.i18n.default_locale = :ja

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.test_framewark :rspec,
                      model_specs: true,
                      view_specs: false,
                      helper_specs: false,
                      routing_specs: false,
                      controller_specs: false,
                      request_specs: false
    end
  end
end

