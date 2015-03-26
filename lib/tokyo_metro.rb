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
  DICTIONARY_DIR = ::File.expand_path( "#{ PRODUCTION_DIR }/lib/tokyo_metro/dictionary" )

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

  STATION_DICTIONARY = ::YAML.load_file( "#{ DICTIONARY_DIR }/station/tokyo_metro.yaml" )

  def self.reload_all_files!
    open( "#{ TOP_DIR }/required_files.txt" , "r:utf-8" ).read.split( /\n/ ).each do |f|
      load "#{ ::Rails.root }/#{ f }"
    end
  end

  def self.station_dictionary_including_main_info( stations_of_railway_lines = nil )
    if stations_of_railway_lines.nil?
      stations_of_railway_lines = ::Station::Info.where( operator_id: ::Operator.id_of_tokyo_metro )
    end

    h = ::Hash.new

    station_dictionary.each do | name_in_system , name_ja |
      stations_in_db = stations_of_railway_lines.where( name_in_system: name_in_system )
      name_h = {
        :name_ja => stations_in_db.first.name_ja ,
        :name_hira => stations_in_db.first.name_hira ,
        :name_en => stations_in_db.first.name_en ,
        :name_in_system => name_in_system ,
        :station_codes => stations_in_db.pluck( :station_code )
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

  def self.set_modules
    # TokyoMetro::Modules::Common::ConvertConstantToClassMethod の TokyoMetro への include は、
    # tokyo_metro/modules/common/convert_constant_to_class_method.rb で行う。

    module_library.each do | module_type , categories |
      categories.each do | category , namespaces |
        [ namespaces ].flatten.each do | namespace |
          eval <<-SET
            ::TokyoMetro::Modules::Api::Convert::#{module_type}::#{category}::#{namespace}.set_modules
          SET
        end
      end
    end

  end

  # @!group 定数

  # 定数の定義
  def self.set_constants( config_of_api_constants = nil )
    set_fundamental_constants
    set_api_constants( config_of_api_constants )
  end

  def self.set_fundamental_constants
    ::TokyoMetro::Static::set_constants
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

    alias :set_api_consts :set_api_constants
    alias :set_all_api_consts :set_all_api_constants
    alias :set_all_api_consts_without_fare :set_all_api_constants_without_fare

    private

    def module_library
      h = ::Hash.new

      #---------------- StationTimetable, TrainTimetable ... Patches と Customize で共通して用いるモジュール

      set_namespaces_to_module_library( h , :Common , :Station ,
        :ConnectingRailwayLine
      )

      set_namespaces_to_module_library( h , :Common , :TrainInfos ,
        :ConvertStation ,
        :ConvertTerminalStation ,
        :ConvertStartingStation
      )

      set_namespaces_to_module_library( h , :Common , :StationTimetable ,
        :ConvertTerminalStations
      )

      #---------------- Patches

      set_namespaces_to_module_library( h , :Patches , :Station ,
        :ConnectingRailwayLine
      )

      set_namespaces_to_module_library( h , :Patches , :StationFacility ,
        :EscalatorDirection ,
        :RailwayDirectionInPlatformTransferInfo ,
        :BarrierFreeFacilityLocatedArea
      )

      set_namespaces_to_module_library( h , :Patches , :TrainInfos ,
        :MusashiKosugiInNambokuLine
      )

      set_namespaces_to_module_library( h , :Patches , :StationTimetable ,
        :MusashiKosugiInNambokuLine ,
        :NakanoSakaueOnMarunouchiBranchLine ,
        :Origin ,
        :FukutoshinLineForWakoshi ,
        :MarunouchiBranchLineForNakanoSakaue
      )

      set_namespaces_to_module_library( h , :Patches , :TrainTimetable ,
        :YurakuchoLine
      )

      #---------------- Customize

      set_namespaces_to_module_library( h , :Customize , :Fare ,
        :ChiyodaBranchLine
      )

      set_namespaces_to_module_library( h , :Customize , :RailwayLine ,
        :ChiyodaBranchLine
      )

      set_namespaces_to_module_library( h , :Customize , :Station ,
        :ChiyodaBranchLine ,
        :StationCodeOfNakanoSakaueOnMarunouchiBranchLine ,
        :ConnectingRailwayLine
      )

      set_namespaces_to_module_library( h , :Customize , :StationFacility ,
        :RailwayLineNameInPlatformTransferInfo ,
        :MarunouchiBranchLine ,
        :ChiyodaBranchLine
      )

      set_namespaces_to_module_library( h , :Customize , :TrainTimetable ,
        :StartingStation ,
        :ReplaceStationName ,
        # :MarunouchiBranchLine ,
        :ChiyodaBranchLine ,
        :ToeiMitaLine ,
        :TrainRelationsOnMarunouchiBranchLine
      )

      set_namespaces_to_module_library( h , :Customize , :StationTimetable ,
        # :MarunouchiBranchLine ,
        :ChiyodaBranchLine ,
        :AdditionalInfos
      )

      set_namespaces_to_module_library( h , :Customize , :TrainInfos ,
        :ConvertStation ,
        :ConvertTerminalStation ,
        :ConvertStartingStation ,
        :MarunouchiBranchLine ,
        :ChiyodaBranchLine ,
        :ToeiMitaLine ,
        :RomanceCar
      )

      h
    end

    def set_namespaces_to_module_library( h , module_type , category , *namespaces )
      if h[ module_type ].nil?
        h[ module_type ] = ::Hash.new
      end
      if h[ module_type ][ category ].nil?
        h[ module_type ][ category ] = ::Array.new
      end
      namespaces.flatten.each do | namespace |
        h[ module_type ][ category ] << namespace
      end
    end

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

__END__

::TokyoMetro.set_api_consts

#--------

::TokyoMetro::Static.operators.seed
::TokyoMetro::Static.train_owners.seed
::TokyoMetro::Static::Fare::Normal.seed
::TokyoMetro::Static.operation_days.seed
::TokyoMetro::Static.train_information_statuses.seed
::TokyoMetro::Static.railway_lines.seed
::TokyoMetro::Api.station_facilities.seed

::TokyoMetro::Api.stations.seed
::TokyoMetro::Static.stations.seed
::TokyoMetro::Api.stations.seed_connecting_railway_lines

::TokyoMetro::Static.railway_directions.seed
::TokyoMetro::Static.train_types_in_api.seed
::TokyoMetro::Static.train_types.seed
::TokyoMetro::Api.points.seed
::TokyoMetro::Api.stations.seed_exits
::TokyoMetro::Api.railway_lines.seed_travel_time_infos
::TokyoMetro::Api.railway_lines.seed_women_only_car_infos
::TokyoMetro::Api.passenger_surveys.seed
::TokyoMetro::Api.stations.seed_link_to_passenger_surveys

::TokyoMetro::Api.station_facilities.seed_barrier_free_facilities

::TokyoMetro::Api.station_facilities.seed_platform_infos

#--------

::TokyoMetro.set_api_consts

::TokyoMetro::Api.fares.seed

#--------

Refinement