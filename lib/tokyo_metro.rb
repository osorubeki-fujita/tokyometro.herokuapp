# Encoding.default_external
# require 'psych'

require 'date' # 時刻ライブラリ
require 'yaml'
require 'singleton'
require 'fileutils'

# 東京メトロ オープンデータを扱うモジュール
module TokyoMetro

  # プロジェクトのトップディレクトリ
  # @note "#{ ::Rails.root }" とはしない
  TOP_DIR = ::File.expand_path( "#{ File.dirname( __FILE__ ) }/.." )

  # @!group ディレクトリ

  # 本番環境に移行するファイルを格納するディレクトリ
  PRODUCTION_DIR = TOP_DIR

  # 開発のためのファイルを格納するディレクトリ
  DEV_DIR = ::File.expand_path( "#{TOP_DIR}/../rails_tokyo_metro_dev" )

  # データベースのディレクトリ
  DB_DIR = ::File.expand_path( "#{TOP_DIR}/../rails_tokyo_metro_db" )

  # 辞書ファイルのディレクトリ
  DICTIONARY_DIR = ::File.expand_path( "#{ PRODUCTION_DIR }/lib/dictionary" )

  # @!group API へのアクセス

  # Access Token
  # @note API アクセス用のアクセストークン【必須】【アプリケーションごとに固有】<acl:consumerKey - acl:ConsumerKey>
  # @note 複数のアプリケーションを作成する場合は、それぞれについて取得すること。
  # @note  【公開禁止】
  ACCESS_TOKEN = open( "#{ DICTIONARY_DIR }/access_token.txt" , "r:utf-8" ).read

  # 東京メトロオープンデータ API のエンドポイント
  API_ENDPOINT = "https://api.tokyometroapp.jp/api/v2"

  # データ取得・検索 API
  DATAPOINTS_URL = "#{API_ENDPOINT}/datapoints"

  # 地物情報取得・検索 API
  PLACES_URL = "#{API_ENDPOINT}/places"

  # @!group HTML, CSS, HAML, SCSS

  # HTML のディレクトリ
  HTML_DIR = "#{ DEV_DIR }/app/html"

  # HAML のディレクトリ
  HAML_DIR = "#{ DEV_DIR }/app/haml"

  # CSS のディレクトリ
  CSS_DIR = "#{ DEV_DIR }/app/assets/css"

  # SCSS のディレクトリ
  SCSS_DIR = "#{ DEV_DIR }/app/assets/scss"

  # @!group DB

  # Rails の fixture ファイルを格納するディレクトリ
  RAILS_FIXTURES_DIR = "#{ PRODUCTION_DIR }/test/fixtures"

  # @!group 駅名辞書

  STATION_DICTIONARY = "#{ DICTIONARY_DIR }/station/tokyo_metro.yaml"

  def self.station_dictionary_including_main_info( stations_of_railway_lines = nil )
    if stations_of_railway_lines.nil?
      stations_of_railway_lines = ::Station.where( operator_id: ::Operator.id_of_tokyo_metro )
    end

    h = ::Hash.new

    station_dictionary.each do | name_in_system , name_ja |
      station_instances = stations_of_railway_lines.where( name_in_system: name_in_system )
      name_h = {
        :name_ja => station_instances.first.name_ja ,
        :name_hira => station_instances.first.name_hira ,
        :name_en => station_instances.first.name_en ,
        :name_in_system => name_in_system ,
        :station_codes => station_instances.pluck( :station_code )
      }
      h[ name_in_system ] = name_h
    end

    return h
  end

  # @!group 時刻

  # ダイヤ上の日付変更時刻
  CHANGE_DATE = 3

  # 現在時刻
  # @note タイムゾーンは日本時間 (GMT+9)
  # @return [DateTime]
  def self.time_now
    time_zone = Rational( 9 , 24 )
    ::DateTime.now.new_offset( time_zone )
  end

  # @!group モジュールの組み込み

  # 標準添付ライブラリの拡張
  def self.extend_builtin_libraries
    [ "String" , "Object" , "DateTime" , "Integer" , "Symbol" ].each do | class_name |
      eval( "::#{ class_name }" ).class_eval do
        include eval( "::ForRails::ExtendBuiltinLibraries::#{ class_name }Module" )
      end
    end

    # Module.class_eval do
    ::Object.class_eval do
      include ::ForRails::ExtendBuiltinLibraries::NamespaceModule
    end
  end

  def self.set_modules
    # TokyoMetro::CommonModules::ConvertConstantToClassMethod の TokyoMetro への include は、
    # tokyo_metro/common_modules/convert_constant_to_class_method.rb で行う。
    
    #-------- Error などの処理 (1) StationFacility

    ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo.set_modules
    ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ConvertRailwayLineName.set_modules
    ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ProcessInvalidRailwayDirection.set_modules

    #-------- Error などの処理 (2) StationTimetable

    ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::Fundamental.set_modules
    ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::MarunouchiBranchLineForNakanoSakaue.set_modules
    ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::NambokuLineForMusashiKosugi.set_modules
    ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::FukutoshinLineForWakoshi.set_modules

    ::TokyoMetro::ApiModules::Customize::StationTimetable::ConvertInfosRelatedToMarunouchiBranchLine.set_modules
    ::TokyoMetro::ApiModules::Customize::StationTimetable::ProcessInfoOfStartingStation.set_modules
    ::TokyoMetro::ApiModules::Customize::StationTimetable::ProcessInfoOfTerminalStation.set_modules

    #-------- Error などの処理 (3) TrainTimetable

    ::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::Fundamental.set_modules
    ::TokyoMetro::ApiModules::Customize::TrainTimetable::ConvertStations::NambokuLineForMusashiKosugi.set_modules

    ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetValidInfosToInvalidTrainsInYurakuchoLine.set_modules
    ::TokyoMetro::ApiModules::Customize::TrainTimetable::SetStationName.set_modules
    ::TokyoMetro::ApiModules::Customize::TrainTimetable::TrainType.set_modules

    #---------------- モジュールの include

    ::TokyoMetro::ApiModules::TimetableModules.include_pattern_b
  end

  # @!group 定数

  # 定数の定義
  def self.set_constants( config_of_api_constants = nil )
    set_fundamental_constants
    set_api_constants( config_of_api_constants )
  end

  def self.set_fundamental_constants
    ::TokyoMetro::StaticDatas::set_constants
    ::TokyoMetro::Api.set_constants_for_timetable
  end

  def self.set_api_constants( config_of_api_constants = nil )
    ::TokyoMetro::Api::set_constants( config_of_api_constants )
  end

  def self.set_all_api_constants
    set_api_constants( config_of_api_constants_when_load_all )
  end

  def self.set_all_api_constants_without_fare
    set_api_constants( config_of_api_constants_when_load_without_fare )
  end

  class << self

    private

    def config_of_api_constants_when_load_all
      h = ::Hash.new
      config_api_constant_keys.each do | key |
        h[ key ] = true
      end
      h
    end

    def config_of_api_constants_when_load_without_fare
      h = ::Hash.new
      ( config_api_constant_keys - [ :fare ] ).each do | key |
        h[ key ] = true
      end
      h
    end

    def config_api_constant_keys
      [ :station_facility , :passenger_survey , :station , :railway_line , :point , :fare , :station_timetable , :train_timetable ]
    end

  end

  # @!endgroup

end