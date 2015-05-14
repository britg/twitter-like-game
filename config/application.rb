require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tavernlight
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths += %W(
      #{config.root}/app/core
      #{config.root}/app/workers
      #{config.root}/app/calculators
    )

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.generators do |g|
      g.template_engine false
      g.test_framework :rspec, :fixture_replacement => :factory_girl
      g.fixture_replacement :factory_girl, dir: "spec/factories"
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.assets false
      g.view_specs false
    end
  end
end
