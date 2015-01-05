require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTokyoMetro
  class Application < Rails::Application
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

    module RequiredFiles

      def self.all
        required_files = Array.new

        class << required_files
          include ArrayMethod
        end

        required_files = for_rails( required_files )
        required_files = fundamental( required_files )
        required_files = others( required_files )
        required_files = api_modules( required_files )

        required_files = factories( required_files )
        required_files = static_datas( required_files )
        required_files = api( required_files )

        display_files_not_be_required( required_files )
        output_required_files( required_files )

        return required_files
      end

      class << self

        private

        def display_files_not_be_required( required_files )
          all_files = ::Dir.glob( "#{ ::Rails.root }/lib/tokyo_metro/**/**.rb" )
          files_not_be_required = ( all_files.map { | str | str.gsub( /\.rb\Z/ , "" ) } - required_files.map { | str | str.gsub( /\.rb\Z/ , "" ) } ).sort

          if files_not_be_required.present?
            files_not_be_required = files_not_be_required.map { | str | str + ".rb" }
            puts "● These files will not be required."
            puts files_not_be_required
            puts ""
          end
        end

        def output_required_files( required_files )
          open( "#{ ::Rails.root }/required_files.txt" , "w:utf-8" ) do |f|
            f.print required_files.map { | str | str + ".rb" }.join( "\n" )
          end
        end

      end

      module ArrayMethod

        def set_files( *files )
          files.flatten.each do | file |
            filename_without_extension = file.gsub( /\.rb\Z/ , "" )
            filename_with_extension = filename_without_extension + ".rb"
            if File.exist?( filename_with_extension ) and !( self.include?( filename_without_extension ) )
              self << filename_without_extension
            end
          end
          return self
        end

        def set_files_starting_with( *dir_root )
          dir_root = dir_root.flatten
          self.set_files File.join( *dir_root )
          self.set_files Dir.glob( "#{ dir_root.join( "/" ) }/**/**.rb" ).sort
          return self
        end

      end

      # 組み込みライブラリの拡張、共通して使用するモジュールなど
      def self.for_rails( ary )
        ary.set_files_starting_with( ::Rails.root , "lib" , "for_rails" )
        return ary
      end

      def self.fundamental( ary )
        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" )
        return ary
      end

      def self.others( ary )
        #---------------- extension_of_builtin_libraries
        #---------------- seed / DB への流し込み
        #---------------- class_name_library / クラス名のライブラリ
        #---------------- search / 検索
        #---------------- save_realtime_info / リアルタイム情報の取得
        #---------------- scss
        #---------------- common_modules / 様々なクラスに組み込むモジュール
        #---------------- static_data_modules / 変化のない（or 非常に少ない）情報を扱うクラスに組み込むモジュール
        #---------------- test
        #---------------- document
        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" )
        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" , "convert_constant_to_class_method" )

        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" , "dictionary" )

        [ "railway_line" , "station" ].each do | dictionary_type |
          ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" , "dictionary" , dictionary_type )
          [ "string_info" , "string_list" , "regexp_info" ].each do | namespace |
            ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" , "dictionary" , dictionary_type , namespace )
          end
        end

        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" , "decision" )
        ary.set_files_starting_with( ::Rails.root , "lib" , "tokyo_metro" , "common_modules" , "decision" , "station_regexp_library" )

        other_namespaces.each do | namespace |
          ary.set_files_starting_with( ::Rails.root , "lib" , "tokyo_metro" , namespace )
        end
        return ary
      end

      # api_modules / API を扱うクラスに組み込むモジュール
      def self.api_modules( ary )
        api_modules_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "api_modules" ]
        ary.set_files File.join( *api_modules_dir_root )

        #-------- timetable_modules

        timetable_modules_dir_root = api_modules_dir_root + [ "timetable_modules" ]

        ary.set_files File.join( *timetable_modules_dir_root )

        ary.set_files File.join( *timetable_modules_dir_root , "common" )
        ary.set_files File.join( *timetable_modules_dir_root , "common" , "station" )

        train_type_factory_modules_dir_root = timetable_modules_dir_root + [ "common" , "train_type_factory_modules" ]

        ary.set_files File.join( *train_type_factory_modules_dir_root )
        ary.set_files File.join( *train_type_factory_modules_dir_root , "pattern_modules" )
        ary.set_files File.join( *train_type_factory_modules_dir_root , "pattern_modules" , "methods" )

        ary.set_files_starting_with( train_type_factory_modules_dir_root )

        ary.set_files File.join( *timetable_modules_dir_root , "common" , "train_type_factory" )

        [ "timetable" , "train_timetable" , "station_train_time" ].each do | namespace |
          ary.set_files_starting_with( *timetable_modules_dir_root , namespace )
        end

        #--------

        ary.set_files_starting_with( api_modules_dir_root )
        return ary
      end

      # factories / Facetory Pattern
      def self.factories( ary )
        factories_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "factories" ]

        ary.set_files File.join( *factories_dir_root )

        #-------- api

        factories_api_dir_root = factories_dir_root + [ "api" ]
        ary.set_files File.join( *factories_api_dir_root )
        ary.set_files Dir.glob( "#{ factories_api_dir_root.join( "/" ) }/**.rb" ).sort

        #---- generate_from_hash

        factories_api_generate_from_hash_dir_root = factories_api_dir_root + [ "generate_from_hash" ]
        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "meta_class" )
        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "meta_class" , "fundamental" )
        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "meta_class" , "not_on_the_top_layer" )

        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "station_facility" )
        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "station_facility" , "info" )
        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "station_facility" , "info" , "barrier_free" )
        ary.set_files File.join( *factories_api_generate_from_hash_dir_root , "station_facility" , "info" , "barrier_free" , "service_detail" )

        ary.set_files_starting_with( factories_api_generate_from_hash_dir_root )

        #---- get

        factories_api_get_dir_root = factories_api_dir_root + [ "get" ]
        ary.set_files File.join( *factories_api_get_dir_root , "meta_class" )
        ary.set_files File.join( *factories_api_get_dir_root , "meta_class" , "fundamental" )
        ary.set_files File.join( *factories_api_get_dir_root , "meta_class" , "data_search" )
        ary.set_files File.join( *factories_api_get_dir_root , "meta_class" , "geo" )
        ary.set_files_starting_with( factories_api_get_dir_root )

        #---- generate_from_saved_file

        factories_api_generate_from_saved_file_dir_root = factories_api_dir_root + [ "generate_from_saved_file" ]
        ary.set_files File.join( *factories_api_generate_from_saved_file_dir_root , "meta_class" )
        ary.set_files File.join( *factories_api_generate_from_saved_file_dir_root , "meta_class" , "normal" )
        ary.set_files File.join( *factories_api_generate_from_saved_file_dir_root , "meta_class" , "date" )
        ary.set_files_starting_with( factories_api_generate_from_saved_file_dir_root )

        #---- save

        factories_api_save_dir_root = factories_api_dir_root + [ "save" ]
        ary.set_files File.join( *factories_api_save_dir_root , "meta_class" )
        ary.set_files File.join( *factories_api_save_dir_root , "meta_class" , "fundamental" )
        ary.set_files File.join( *factories_api_save_dir_root , "meta_class" , "data_search" )
        ary.set_files_starting_with( factories_api_save_dir_root )

        #---- save_grouped_data

        factories_api_save_grouped_data_dir_root = factories_api_dir_root + [ "save_grouped_data" ]
        ary.set_files_starting_with( *factories_api_save_grouped_data_dir_root , "meta_class" )
        ary.set_files_starting_with( factories_api_save_grouped_data_dir_root )

        #---- seed

        ary.set_files_starting_with( *factories_api_dir_root , "seed" )

        #-------- static_datas

        factories_static_datas_dir_root = factories_dir_root + [ "static_datas" ]
        ary.set_files File.join( *factories_static_datas_dir_root )

        factories_static_datas_meta_class_dir_root = factories_static_datas_dir_root + [ "meta_class" ]
        ary.set_files File.join( *factories_static_datas_meta_class_dir_root )

        [ "fundamental" , "each_file_for_multiple_yamls" , "multiple_yamls" ].each do | filename |
          ary.set_files File.join( *factories_static_datas_meta_class_dir_root , filename )
        end

        ary.set_files_starting_with( factories_static_datas_dir_root )

        #-------- scss

        factories_scss_root = factories_dir_root + [ "scss" ]
        ary.set_files File.join( *factories_scss_root )

        [ "fundamental" , "colors" ].each do | filename |
          ary.set_files File.join( *factories_scss_root , filename )
        end

        [ "operators" , "railway_lines" , "train_types" ].each do | namespace |
          each_namespace_root = factories_scss_root + [ namespace ]
          ary.set_files File.join( *each_namespace_root )
          [ "dirname_settings" , "fundamental" , "colors" ].each do | filename |
            dir_root = each_namespace_root + [ filename ]
            ary.set_files Dir.glob( "#{ dir_root.join( "/" ) }.rb" ).sort
          end
        end

        #-------- yaml_station_list

        ary.set_files_starting_with( *factories_dir_root , "yaml_station_list" )

        return ary
      end

      # static_datas / 変化のない（or 非常に少ない）情報を扱うクラス
      def self.static_datas( ary )
        static_datas_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "static_datas" ]
        ary.set_files File.join( *static_datas_dir_root )

        static_data_classes.each do | static_data_class |
          ary.set_files_starting_with( *static_datas_dir_root , static_data_class )
        end

        #-------- train_type
        ary.set_files File.join( *static_datas_dir_root , "train_type" )

        train_type_classes = Array.new
        train_type_classes += [ "in_api" , "color" ]
        train_type_classes.each do | train_type_class |
          ary.set_files_starting_with( *static_datas_dir_root , "train_type" , train_type_class )
        end

        train_type_custom_dir_root = static_datas_dir_root + [ "train_type" , "custom" ]
        ary.set_files File.join( *train_type_custom_dir_root )

        custom_train_type_classes = [ "other_operators" , "default_setting" , "main" ]
        custom_train_type_classes.each do | custom_train_type_class |
          ary.set_files_starting_with( *train_type_custom_dir_root , custom_train_type_class )
        end

        return ary
      end

      # api / API を扱うモジュール
      def self.api( ary )
        api_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "api" ]
        dir_api = api_dir_root.join( "/" )

        ary.set_files File.join( *api_dir_root )
        ary.set_files File.join( *api_dir_root , "meta_class" )

        api_meta_classes.each do | api_meta_class |
          ary.set_files_starting_with( *api_dir_root , "meta_class" , api_meta_class )
        end

        api_classes.each do | api_class |
          ary.set_files File.join( *api_dir_root , api_class )
          ary.set_files File.join( *api_dir_root , api_class , "info" )
          ary.set_files File.join( *api_dir_root , api_class , "list" )
        end

        #-------- point

        ary.set_files File.join( *api_dir_root , "point" , "info" , "title" )

        #-------- railway_line

        ary.set_files Dir.glob( "#{ dir_api }/railway_line/info/**/**.rb" ).sort

        #-------- station

        ary.set_files Dir.glob( "#{ dir_api }/station/info/**/**.rb" ).sort

        #-------- station_facility

        station_facility_info_dir_root = api_dir_root + [ "station_facility" , "info" ]
        dir_station_facility_info = station_facility_info_dir_root.join( "/" )

        ary.set_files File.join( *station_facility_info_dir_root )
        ary.set_files File.join( *station_facility_info_dir_root , "barrier_free" )
        ary.set_files File.join( *station_facility_info_dir_root , "barrier_free" , "info" )

        ary.set_files Dir.glob( "#{ dir_station_facility_info }/barrier_free/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/barrier_free/service_detail/**/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/barrier_free/facility/**/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/platform/**/**.rb" ).sort

        #-------- station_timetable

        station_timetable_info_dir_root = api_dir_root + [ "station_timetable" , "info" ]
        dir_station_timetable_info = station_timetable_info_dir_root.join( "/" )

        ary.set_files File.join( *station_timetable_info_dir_root , "hash" )
        ary.set_files File.join( *station_timetable_info_dir_root , "train" )
        ary.set_files File.join( *station_timetable_info_dir_root , "train" , "list" )
        ary.set_files File.join( *station_timetable_info_dir_root , "train" , "info" )

        #---- note

        station_timetable_note_root = station_timetable_info_dir_root + [ "train" , "info" , "note" ]
        dir_station_timetable_note = station_timetable_note_root.join( "/" )

        ary.set_files File.join( *station_timetable_note_root )
        ary.set_files Dir.glob( "#{ dir_station_timetable_note }/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_timetable_note }/shirokane_takanawa/**.rb" ).sort

        [ "fundamental" , "ayase" , "wakoshi" ].each do | filename |
          ary.set_files File.join( *station_timetable_note_root , "starting_station" , filename )
        end

        station_timetable_note_yurakucho_fukutoshin_root = station_timetable_note_root + [ "yurakucho_fukutoshin" ]
        dir_note_station_timetable_note_yurakucho_fukutoshin = station_timetable_note_yurakucho_fukutoshin_root.join( "/" )

        ary.set_files Dir.glob( "#{ dir_note_station_timetable_note_yurakucho_fukutoshin }/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_note_station_timetable_note_yurakucho_fukutoshin }/kotake_mukaihara/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_note_station_timetable_note_yurakucho_fukutoshin }/train_type/**.rb" ).sort

        railway_lines_of_train_type = [ "fundamental" , "seibu_ikebukuro" , "tobu_tojo" , "tokyu_toyoko" ]
        railway_lines_of_train_type.each do | filename |
          dir_root = station_timetable_note_yurakucho_fukutoshin_root + [ "train_type" , filename ]
          ary.set_files File.join( *dir_root )
          ary.set_files Dir.glob( "#{ dir_root.join("/") }/fundamental.rb" ).sort
          ary.set_files Dir.glob( "#{ dir_root.join("/") }/**.rb" ).sort
        end

        #-------- train_timetable

        ary.set_files Dir.glob( "#{ dir_api }/train_timetable/info/**/**.rb" ).sort

        return ary
      end

      class << self

        private

        def other_namespaces
          [
            "extend_builtin_libraries" , "seed" , "class_name_library" , "search" , "save_realtime_info" , "scss" ,
            "common_modules" , "static_data_modules" , "test" , "document"
          ]
        end

        def static_data_classes
          ary = ::Array.new
          ary << "fundamental"
          ary += [ "fare" , "color" , "operator" , "station" ]
          ary += [ "railway_direction" , "railway_line" , "stations_in_tokyo_metro" , "stopping_pattern" , "train_owner" ]
          ary -= [ "stopping_pattern" ]
          ary
        end

        def api_meta_classes
          [ "fundamental" , "data_search" , "not_real_time" , "real_time" , "geo" , "hybrid" ]
        end

        def api_classes
          [
            "fare" , "mlit_railway_line" , "mlit_station" , "passenger_survey" , "point" , "railway_line" ,
            "station" , "station_facility" , "station_timetable" , "train_information" , "train_location" , "train_timetable"
          ]
        end
      end

    end

    config.after_initialize do

      #---------------- ファイルの require

      RequiredFiles.all.each do | f |
        require f
      end

      #---------------- 標準添付ライブラリの拡張
      ::TokyoMetro.extend_builtin_libraries

      #---------------- モジュールの組み込み
      ::TokyoMetro.set_modules

      #---------------- 定数の設定
      ::TokyoMetro.set_fundamental_constants

      # ::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )
      # ::TokyoMetro.set_all_api_constants_without_fare
      # ::TokyoMetro.set_all_api_constants
    end

  end
end

__END__

::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )

::TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :marunouchi , :marunouchi_branch )
::TokyoMetro::ApiModules::TimetableModules::StationTrainTime.destory( :marunouchi , :marunouchi_branch )

::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :marunouchi_including_branch )

#--------

・ ::Timetable -> ::StationTimetable の変更

・ TrainLocation に prepend
・ TrainLocation 丸ノ内支線 中野坂上駅の名称の挙動（特に中野富士見町～本線）

・ prepend するモジュール内での include と prepend

・ StationTrainTime seed エラーの挙動

#--------

::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )
::TokyoMetro.set_api_constants( { station_timetable: true } )

puts ::TokyoMetro::Api.station_timetables.select { | item | /NakanoSakaue/ =~ item.same_as }.map { | item | item.same_as }.sort
puts ""
puts ::TokyoMetro::Api.station_timetables.select { | item | item.at_nakano_sakaue? }.map { | item | item.same_as }.sort
puts ""
puts ::TokyoMetro::Api.station_timetables.select { | item | item.at_nakano_sakaue? }.map { | item | item.same_as }.sort

#--------

::TokyoMetro::Api.station_timetables.each do | item |
  ::TokyoMetro::ApiModules::TimetableModules::StationTrainTime::Seed::PatternB::TrainInStationTimetable::StationTimetableInfo.new( item )
end

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

完了 - Errorありの可能性
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :ginza )
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :hibiya )
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :tozai )
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :namboku )

完了
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :hanzomon )
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :yurakucho_fukutoshin )
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :chiyoda )

完了 - Check 前

実行中

未完了
::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time( :marunouchi_including_branch )

#--------

TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :ginza )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :hibiya )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :tozai )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :chiyoda )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :hanzomon )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :namboku )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :yurakucho , :fukutoshin )
TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :marunouchi , :marunouchi_branch )

#--------

TokyoMetro::ApiModules::TimetableModules::StationTrainTime.destory( :marunouchi , :marunouchi_branch )

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

#--------

  Timetable Load (1.0ms)  SELECT  "timetables".* FROM "timetables"  WHERE "timetables"."same_as" = 'odpt.StationTimetable:TokyoMetro.MarunouchiBranch.Honancho.NakanoSakaue' LIMIT 1
  RailwayLine Load (1.0ms)  SELECT  "railway_lines".* FROM "railway_lines"  WHERE "railway_lines"."id" = ? LIMIT 1  [["id", 2]]
  Station Load (1.0ms)  SELECT  "stations".* FROM "stations"  WHERE "stations"."id" = ? LIMIT 1  [["id", 46]]
  RailwayLine Load (1.0ms)  SELECT  "railway_lines".* FROM "railway_lines"  WHERE "railway_lines"."same_as" = 'odpt.Railway:TokyoMetro.Marunouchi' LIMIT 1
  Station Load (6.0ms)  SELECT  "stations".* FROM "stations"  WHERE "stations"."railway_line_id" = 2 AND "stations"."name_in_system" = 'Honancho' LIMIT 1
  RailwayLine Load (2.0ms)  SELECT  "railway_lines".* FROM "railway_lines"  WHERE "railway_lines"."same_as" = 'odpt.Railway:TokyoMetro.MarunouchiBranch' LIMIT 1
  Station Load (1.0ms)  SELECT  "stations".* FROM "stations"  WHERE "stations"."railway_line_id" = 3 AND "stations"."name_in_system" = 'Honancho' LIMIT 1
  OperationDay Load (1.0ms)  SELECT  "operation_days".* FROM "operation_days"  WHERE "operation_days"."name_en" = 'Weekday' LIMIT 1
RuntimeError: Error: The train timetable of these informations does not exist.
Depart from              ... odpt.Station:TokyoMetro.MarunouchiBranch.Honancho (odpt.Railway:TokyoMetro.Marunouchi / odpt.Railway:TokyoMetro.MarunouchiBranch)
Departure time           ... 5:0
Terminal station         ... odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue
Operation day            ... Weekday
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:127:in `train_timetable_of_this_train'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:89:in `block (3 levels) in seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:84:in `each'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:84:in `block (2 levels) in seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:81:in `each'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:81:in `block in seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:71:in `each'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:71:in `seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:44:in `seed'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:38:in `process'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules.rb:55:in `seed_station_train_time'
        from (irb):23
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/console.rb:90:in `start'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/console.rb:9:in `start'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/commands_tasks.rb:69:in `console'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/commands_tasks.rb:40:in `run_command!'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands.rb:17:in `<top (required)>'
        from bin/rails:4:in `require'
        from bin/rails:4:in `<main>'

#--------

  Timetable Load (0.0ms)  SELECT  "timetables".* FROM "timetables"  WHERE "timetables"."same_as" = 'odpt.StationTimetable:TokyoMetro.MarunouchiBranch.NakanoSakaue.Honancho' LIMIT 1
  RailwayLine Load (0.0ms)  SELECT  "railway_lines".* FROM "railway_lines"  WHERE "railway_lines"."id" = ? LIMIT 1  [["id", 2]]
  Station Load (0.0ms)  SELECT  "stations".* FROM "stations"  WHERE "stations"."id" = ? LIMIT 1  [["id", 25]]
  OperationDay Load (0.0ms)  SELECT  "operation_days".* FROM "operation_days"  WHERE "operation_days"."name_en" = 'Weekday' LIMIT 1
RuntimeError: Error: The train timetable of these informations does not exist.
Depart from              ... odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue (odpt.Railway:TokyoMetro.Marunouchi / odpt.Railway:TokyoMetro.MarunouchiBranch)
Departure time           ... 5:8
Terminal station         ... odpt.Station:TokyoMetro.MarunouchiBranch.Honancho
Operation day            ... Weekday
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b/train_in_station_timetable.rb:17:in `find_and_get_train_timetable_infos_of_this_train_
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:80:in `block (3 levels) in seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:78:in `each'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:78:in `block (2 levels) in seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:75:in `each'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:75:in `block in seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:71:in `each'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:71:in `seed__train_times_in_each_station'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:44:in `seed'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules/station_train_time/seed/pattern_b.rb:38:in `process'
        from C:/RubyPj/rails_tokyo_metro/lib/tokyo_metro/api_modules/timetable_modules.rb:49:in `seed_station_train_time'
        from (irb):2
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/console.rb:90:in `start'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/console.rb:9:in `start'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/commands_tasks.rb:69:in `console'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands/commands_tasks.rb:40:in `run_command!'
        from C:/Ruby21/lib/ruby/gems/2.1.0/gems/railties-4.1.8/lib/rails/commands.rb:17:in `<top (required)>'
        from bin/rails:4:in `require'
        from bin/rails:4:in `<main>'irb(main):003:0>
irb(main):004:0* ::TokyoMetro::ApiModules::TimetableModules::StationTrainTime.check_number( :marunouchi , :marunouchi_branch )
   (235.0ms)  SELECT "railway_lines"."id" FROM "railway_lines"  WHERE "railway_lines"."same_as" IN ('odpt.Railway:TokyoMetro.Marunouchi', 'odpt.Railway:TokyoMetro.MarunouchiBranch')
   (15.6ms)  SELECT "timetables"."id" FROM "timetables"  WHERE "timetables"."railway_line_id" IN (2, 3)
   (109.2ms)  SELECT "train_timetables"."id" FROM "train_timetables"  WHERE "train_timetables"."railway_line_id" IN (2, 3)