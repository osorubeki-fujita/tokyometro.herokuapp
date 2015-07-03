Rails.application.configure do

  compress_assets = false

  #--------

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  config.logger = ::Logger.new( "log/development.log" , 'daily' )

  #--------

  unless compress_assets

    # Debug mode disables concatenation and preprocessing of assets.
    # This option may cause significant delays in view rendering with a large
    # number of complex assets.
    config.assets.debug = true

    config.assets.enabled = false

    # Disable Rails's static asset server (Apache or nginx will already do this).
    config.serve_static_files = false

    config.assets.compress = false

    # Generate digests for assets URLs.
    config.assets.digest = false

  else

    # Debug mode disables concatenation and preprocessing of assets.
    # This option may cause significant delays in view rendering with a large
    # number of complex assets.
    config.assets.debug = false

    config.assets.enabled = true

    # Disable Rails's static asset server (Apache or nginx will already do this).
    config.serve_static_files = false

    config.assets.compress = true

    # Compress JavaScripts and CSS.
    config.assets.js_compressor = :uglifier
    config.assets.css_compressor = :yui

    # Generate digests for assets URLs.
    config.assets.digest = true

  end

  #--------

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  config.action_controller.default_url_options = { host: "localhost:3000" }

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  #--------

  config.romance_car_logger = ::Logger.new( ::Rails.root.join( 'log/romance_car_development.log' ) , 'daily' )

  #--------

  config.after_initialize do
    #Bullet.enable = true
    #Bullet.alert = true
    #Bullet.bullet_logger = true
    #Bullet.console = true
    #Bullet.rails_logger = true
  end
end

# ActiveSupport::Dependencies.log_activity = true
