require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Examtutor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Moscow'

    config.i18n.default_locale = :ru
    I18n.available_locales = [:ru, :en]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #
    config.active_job.queue_adapter = :sidekiq

    config.action_cable.disable_request_forgery_protection = false

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       reqiest_specs: false
    end

    config.autoload_paths << "#{Rails.root}/lib/clients"
    config.autoload_paths += [config.root.join('app')]

    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
  end
end
