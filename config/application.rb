require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Acc
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths += Dir[Rails.root.join("app", "models", "transaction")]
    config.i18n.load_path += Dir[Rails.root.join('locales', '*.uz.yml')]
  	config.i18n.default_locale = :uz
    # config.after_initialize do
      # Date::DATE_FORMATS[:default] = I18n.t('date.formats.default')
    # end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
