require_relative "boot"

require "rails/all"

require "carrierwave"

require File.expand_path("../boot", __FILE__)
# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.available_locales = [:en]
    config.assets.precompile += %w( materialize.min.js  materialize.min.css, login.css, common/jquery.min.js )
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
