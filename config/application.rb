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

    # config.autoload_paths << Rails.root.join("lib")
    # NameError: uninitialized constant TokyoMetro::Api::MetaClass::NotRealTime::Info::Train

    # config.autoload_paths += Dir.glob( "#{ ::Rails.root }/lib/**/" )
    # LoadError: Unable to autoload constant Train, expected C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api/station_timetable/info/train.rb to define it

    # config.autoload_once_paths << Rails.root.join("lib")
    # NameError: uninitialized constant TokyoMetro::Api::MetaClass::NotRealTime::Info::Train

    # config.autoload_once_paths += Dir.glob( "#{ ::Rails.root }/lib/**/" )
    # LoadError: Unable to autoload constant Train, expected C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api/station_timetable/info/train.rb to define it

    #----------------

    config.eager_load_paths += Dir[ ::Rails.root.join('app', 'decorators', 'concerns') ]
    config.eager_load_paths += Dir[ ::Rails.root.join('app', 'decorators', 'concerns','association') ]

    # 標準添付ライブラリの拡張
    def self.extend_builtin_libraries
      [ :String , :Object , :DateTime , :Integer , :Symbol , :Time , :Hash ].each do | class_name |
        eval <<-INCLUDE
          ::#{ class_name }.class_eval do
            include ::ForRails::ExtendBuiltinLibraries::#{ class_name }Module
          end
        INCLUDE
      end
      
      ::DateTime.class_eval do
        include ::ForRails::ExtendBuiltinLibraries::TimeModule
      end

      # Module.class_eval do
      ::Object.class_eval do
        include ::ForRails::ExtendBuiltinLibraries::NamespaceModule
      end
    end

    #-------- config.after_initialize ここから

    config.after_initialize do

      #---------------- ファイルの require
      Dir.glob( "#{ ::Rails.root }/config/application/**/**.rb" ).sort.each do | f |
        require f
      end

      RequiredFiles::All.files.each do | f |
        require f
      end

      #---------------- 標準添付ライブラリの拡張
      extend_builtin_libraries

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

      ::ActiveRecord::Base.logger = nil

      # PROCESSOR_OF_REAL_TIME_INFOS = ::TokyoMetro::ApiProcessor::RealTimeInfos.instance
    end
    #-------- config.after_initialize ここまで
  end
end

__END__

# ꇐ

TokyoMetro::Api::StationTrainTime.seed( :ginza )

TokyoMetro::Factory::Seed.destroy_all_items_of( ::StationTrainTime )

#--------

::TokyoMetro::Api::StationTrainTime.check_number( :marunouchi , :marunouchi_branch )
::TokyoMetro::Api::StationTrainTime.destory( :marunouchi , :marunouchi_branch )

::TokyoMetro::Api::StationTrainTime.seed( :marunouchi_including_branch )

#--------

・ TrainLocation に prepend
・ TrainLocation 丸ノ内支線 中野坂上駅の名称の挙動（特に中野富士見町～本線）

・ prepend するモジュール内での include と prepend

・ ::Timetable -> ::StationTimetable の変更

・ StationTrainTime seed エラーの挙動

#--------

puts ::TokyoMetro::Api.station_timetables.select { | item | /NakanoSakaue/ =~ item.same_as }.map { | item | item.same_as }.sort
puts ""
puts ::TokyoMetro::Api.station_timetables.select { | item | item.at_nakano_sakaue? }.map { | item | item.same_as }.sort

#--------

puts ::TokyoMetro::Api.station_timetables.select { | item | /NakanoSakaue/ =~ item.same_as }.map { | item | item.same_as }.sort
puts ::TokyoMetro::Api.station_timetables.select { | item | item.at_nakano_sakaue? }.map { | item | item.same_as }.sort
puts TokyoMetro::CommonModules::Decision::CurrentStation.instance_methods.sort

puts ::TokyoMetro::CommonModules::Dictionary::Station::StringList.constants( false ).map { | const_name | const_name.to_s.downcase }.delete_if { | base_method_name | /_in_system\Z/ === base_method_name }.sort
str = "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue"
class << str
include TokyoMetro::CommonModules::Decision::CurrentStation
end
str.at_nakano_sakaue?
TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.nakano_sakaue

puts ::TokyoMetro::Api.station_timetables.select { | item | /NakanoSakaue/ =~ item.same_as }.map { | item | item.station }.sort

#--------

# ary = TokyoMetro::Api::TrainLocation::generate_from_saved_json( 2014 , 10 , 6 , line: "Ginza" , max: 100 )

#--------

::TokyoMetro::Api.station_timetables.select { | timetable |
  timetable.at_honancho_including_invalid? or timetable.at_nakano_fujimicho_including_invalid? or timetable.at_nakano_shimbashi_including_invalid?
}.map { | timetable |
  timetable.timetables.map { | timetable_for_a_day |
    timetable_for_a_day.map { | train |
      train.terminal_station
    }
  }
}.flatten.uniq.sort

#--------

::TokyoMetro::Api.station_timetables.select { | timetable |
  timetable.at_honancho_including_invalid? or timetable.at_nakano_fujimicho_including_invalid? or timetable.at_nakano_shimbashi_including_invalid?
}.map { | timetable |
  timetable.timetables.map { | timetable_for_a_day |
    timetable_for_a_day.select { | train | train.terminate_at_nakano_sakaue? }.length
  }
}.flatten.inject( :+ )

#--------

::TokyoMetro.set_api_constants( { station_timetable: true } )
puts ::TokyoMetro::Api.station_timetables.select { | item | item.marunouchi_line_including_branch? }.length