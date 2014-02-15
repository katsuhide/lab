require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module HerokuTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # LESS
    # config.app_generators.stylesheet_engine :less
    # config.less.paths << "#{Rails.root}/lib/less/protractor/stylesheets"
    # config.less.compress = true
    config.assets.compress = true
    config.assets.initialize_on_precompile=false # herokuでasset:precomileエラー対策

    # Set timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # generatorの設定
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end


    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
