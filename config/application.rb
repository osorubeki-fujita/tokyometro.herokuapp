require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

#-------- [begin] RailsTokyoMetro
module RailsTokyoMetro

  #-------- [begin] RailsTokyoMetro::Application
  class Application < Rails::Application

    def self.processor_of_real_time_infos
      PROCESSOR_OF_REAL_TIME_INFOS
    end

    #----------------

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    #----------------

    config.eager_load_paths += Dir[ ::Rails.root.join('app', 'decorators', 'concerns') ]
    config.eager_load_paths += Dir[ ::Rails.root.join('app', 'decorators', 'concerns','association') ]
    config.eager_load_paths += Dir[ ::Rails.root.join('app', 'models', 'concerns') ]
    config.eager_load_paths += Dir.glob( "#{ ::Rails.root }/lib/**/" )

    #-------- [begin] config.after_initialize

    config.after_initialize do

      ::TokyoMetro.set_access_token
      ::TokyoMetro::Factory::Decorate::MetaClass.initialize_in_rails_app

      #---------------- モジュールの組み込み
      ::TokyoMetro.set_modules

      #---------------- 定数の設定
      ::TokyoMetro.set_fundamental_constants

      # ::TokyoMetro.set_api_consts( :station_facility , :passenger_survey , :station , :railway_line , :point )

      # ::TokyoMetro.set_api_constants( :station_timetable , :train_timetable )
      # ::TokyoMetro.set_api_constants( :station_timetable )
      # ::TokyoMetro.set_api_constants( :train_timetable )

      # ::TokyoMetro.set_all_api_constants_without_fare

      # ::TokyoMetro.set_all_api_constants

      # PROCESSOR_OF_REAL_TIME_INFOS = ::TokyoMetro::ApiProcessor::RealTimeInfos.instance

      ::ActiveRecord::Base.logger = nil

    end
    #-------- [end] config.after_initialize
  end
end