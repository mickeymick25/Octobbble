require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.logger = Logger.new(STDOUT)
    config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(STDOUT))
    config.log_level = :info
    config.eager_load_paths << Rails.root.join('lib')
  end
end
