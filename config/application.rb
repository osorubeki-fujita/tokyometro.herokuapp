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
        required_files = ::Array.new

        class << required_files
          include ArrayMethod
        end

        required_files = for_rails( required_files )
        required_files = fundamental( required_files )
        required_files = others( required_files )

        required_files = api_modules( required_files )

        # Factories の下部のクラスは ApiModules::ClassNameLibrary を include している。
        required_files = factories( required_files )

        required_files = static( required_files )
        required_files = api( required_files )
        required_files = api_refinements( required_files )

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
          file_list = required_files.map { | str | str.gsub( "#{ ::Rails.root.to_s }/" , "" ) + ".rb" }
          open( "#{ ::Rails.root }/required_files.txt" , "w:utf-8" ) do |f|
            f.print file_list.join( "\n" )
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
        #---------------- class_name_library / クラス名のライブラリ
        #---------------- search / 検索
        #---------------- test
        #---------------- document
        #---------------- common_modules / 様々なクラスに組み込むモジュール
        #---------------- static_modules / 変化のない（or 非常に少ない）情報を扱うクラスに組み込むモジュール
        common_modules_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "common_modules" ]

        [
          [] ,
          [ "convert_constant_to_class_method" ] ,
          [ "dictionary" ]
        ].each do | dir_name |
          ary.set_files File.join( *common_modules_dir_root , *dir_name )
        end

        [ "railway_line" , "station" ].each do | dictionary_type |
          ary.set_files File.join( *common_modules_dir_root , "dictionary" , dictionary_type )
          [ "string_info" , "string_list" , "regexp_info" ].each do | namespace |
            ary.set_files File.join( *common_modules_dir_root , "dictionary" , dictionary_type , namespace )
          end
        end

        ary.set_files File.join( *common_modules_dir_root , "decision" )
        ary.set_files_starting_with( common_modules_dir_root , "decision" , "station_regexp_library" )

        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "class_name_library" )
        ary.set_files File.join( ::Rails.root , "lib" , "tokyo_metro" , "class_name_library" , "api" )
        ary.set_files_starting_with( ::Rails.root , "lib" , "tokyo_metro" , "class_name_library" , "api" , "station_train_time" )

        other_namespaces.each do | namespace |
          ary.set_files_starting_with( ::Rails.root , "lib" , "tokyo_metro" , namespace )
        end
        return ary
      end

      # api_modules / API を扱うクラスに組み込むモジュール
      def self.api_modules( ary )
        api_modules_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "api_modules" ]
        ary.set_files_starting_with( api_modules_dir_root )

        return ary
      end

      # factories / Facetory Pattern
      def self.factories( ary )
        factories_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "factories" ]

        ary.set_files File.join( *factories_dir_root )

        #-------- generate
        set_factories_for_generate( ary , factories_dir_root + [ "generate" ] )
        #-------- get
        set_factories_for_get( ary , factories_dir_root + [ "get" ] )
        #-------- save
        set_factories_for_save( ary , factories_dir_root + [ "save" ] )
        #-------- scss
        set_factories_for_scss( ary , factories_dir_root + [ "scss" ] )
        #-------- seed
        set_factories_for_seed( ary , factories_dir_root + [ "seed" ] )
        #-------- yaml_station_list
        set_factories_for_seed( ary , factories_dir_root + [ "yaml_station_list" ] )

        #-------- common
        factories_common_dir_root = factories_dir_root + [ "common" ]

        ary.set_files_starting_with( factories_common_dir_root )

        #-------- All

        ary.set_files_starting_with( factories_dir_root )

        return ary
      end

      # static / 変化のない（or 非常に少ない）情報を扱うクラス
      def self.static( ary )
        static_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "static" ]
        ary.set_files File.join( *static_dir_root )

        static_classes.each do | static_class |
          ary.set_files_starting_with( static_dir_root , static_class )
        end

        #-------- train_type
        ary.set_files File.join( *static_dir_root , "train_type" )

        train_type_classes = Array.new
        train_type_classes += [ "in_api" , "color" ]
        train_type_classes.each do | train_type_class |
          ary.set_files_starting_with( static_dir_root , "train_type" , train_type_class )
        end

        train_type_custom_dir_root = static_dir_root + [ "train_type" , "custom" ]
        ary.set_files File.join( *train_type_custom_dir_root )

        custom_train_type_classes = [ "other_operator" , "default_setting" , "main" ]
        custom_train_type_classes.each do | custom_train_type_class |
          ary.set_files_starting_with( train_type_custom_dir_root , custom_train_type_class )
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
          ary.set_files_starting_with( api_dir_root , "meta_class" , api_meta_class )
        end

        api_classes.each do | api_class |
          [
            [] ,
            [ "info" ] ,
            [ "list" ]
          ].each do | dir_name |
            ary.set_files File.join( *api_dir_root , api_class , *dir_name )
          end
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

        [
          [] ,
          [ "barrier_free" ] ,
          [ "barrier_free" , "info" ]
        ].each do | dir_name |
          ary.set_files File.join( *station_facility_info_dir_root , *dir_name )
        end

        ary.set_files Dir.glob( "#{ dir_station_facility_info }/barrier_free/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/barrier_free/service_detail/**/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/barrier_free/facility/**/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_facility_info }/**.rb" ).sort

        [
          [ "platform" ] ,
          [ "platform" , "info" ]
        ].each do | dir_name |
          ary.set_files File.join( *station_facility_info_dir_root , *dir_name )
        end

        [
          [ "platform" , "info" , "common" ] ,
          [ "platform" ] ,
          []
        ].each do | dir_name |
          ary.set_files_starting_with( station_facility_info_dir_root , *dir_name )
        end

        #-------- station_train_time

        ary.set_files_starting_with( api_dir_root , "station_train_time" )

        #-------- station_timetable

        station_timetable_info_dir_root = api_dir_root + [ "station_timetable" , "info" ]
        dir_station_timetable_info = station_timetable_info_dir_root.join( "/" )

        [
          [ "hash" ] ,
          [ "train_time" ] ,
          [ "train_time" , "list" ] ,
          [ "train_time" , "info" ]
        ].each do | dir_name |
          ary.set_files File.join( *station_timetable_info_dir_root , *dir_name )
        end

        #---- note

        station_timetable_train_time_note_root = station_timetable_info_dir_root + [ "train_time" , "info" , "note" ]
        dir_station_timetable_train_time_note = station_timetable_train_time_note_root.join( "/" )

        ary.set_files File.join( *station_timetable_train_time_note_root )
        ary.set_files Dir.glob( "#{ dir_station_timetable_train_time_note }/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_station_timetable_train_time_note }/shirokane_takanawa/**.rb" ).sort

        [ "fundamental" , "ayase" , "wakoshi" ].each do | filename |
          ary.set_files File.join( *station_timetable_train_time_note_root , "starting_station" , filename )
        end

        #--------

        station_timetable_train_time_note_yurakucho_fukutoshin_root = station_timetable_train_time_note_root + [ "yurakucho_fukutoshin" ]
        dir_note_station_timetable_train_time_note_yurakucho_fukutoshin = station_timetable_train_time_note_yurakucho_fukutoshin_root.join( "/" )

        ary.set_files Dir.glob( "#{ dir_note_station_timetable_train_time_note_yurakucho_fukutoshin }/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_note_station_timetable_train_time_note_yurakucho_fukutoshin }/kotake_mukaihara/**.rb" ).sort
        ary.set_files Dir.glob( "#{ dir_note_station_timetable_train_time_note_yurakucho_fukutoshin }/train_type/**.rb" ).sort

        railway_lines_of_train_type = [ "fundamental" , "seibu_ikebukuro" , "tobu_tojo" , "tokyu_toyoko" ]
        railway_lines_of_train_type.each do | filename |
          dir_root = station_timetable_train_time_note_yurakucho_fukutoshin_root + [ "train_type" , filename ]
          ary.set_files File.join( *dir_root )
          ary.set_files Dir.glob( "#{ dir_root.join("/") }/fundamental.rb" ).sort
          ary.set_files Dir.glob( "#{ dir_root.join("/") }/**.rb" ).sort
        end

        #--------

        ary.set_files_starting_with( station_timetable_info_dir_root )

        #-------- train_timetable

        train_timetable_info_dir_root = api_dir_root + [ "train_timetable" , "info" ]

        [
          [ "station_time" ] ,
          [ "station_time" , "info" ] ,
          [ "station_time" , "info" , "train_relation" ] ,
          [ "station_time" , "info" , "train_relation" , "meta_class" ] ,
          [ "station_time" , "info" , "train_relation" , "meta_class" , "list" ] ,
          [ "station_time" , "info" , "train_relation" , "meta_class" , "info" ]
        ].each do | dir_name |
          ary.set_files File.join( *train_timetable_info_dir_root , *dir_name )
        end

        ary.set_files Dir.glob( "#{ dir_api }/train_timetable/info/**/**.rb" ).sort

        return ary
      end

      # api_refinements
      def self.api_refinements( ary )
        api_refinements_dir_root = [ ::Rails.root , "lib" , "tokyo_metro" , "api_refinements" ]

        [
          [] ,
          [ "station_timetable" ] ,
          [ "station_timetable" , "info" ] ,
          [ "station_timetable" , "info" , "fundamental" ] ,
          [ "station_timetable" , "info" , "fundamental" , "info" ] ,
          [ "station_timetable" , "info" , "fundamental" , "list" ]
        ].each do | dir_name |
          ary.set_files File.join( *api_refinements_dir_root , *dir_name )
        end

        ary.set_files_starting_with( *api_refinements_dir_root )

        return ary
      end

      class << self

        private

        def other_namespaces
          [
            "extend_builtin_libraries" , "class_name_library" , "search" ,
            "scss" , "test" , "document" ,
            "common_modules" , "static_modules" , "db_modules"
          ]
        end

        def static_classes
          ary = ::Array.new
          ary << "fundamental"
          ary += [ "fare" , "color" , "operator" , "station" ]
          ary += [ "railway_direction" , "railway_line" , "stations_in_tokyo_metro" , "stopping_pattern" , "train_owner" ]
          ary += [ "operation_day" , "train_information_status" ]
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

        def set_factories_for_generate( ary , factories_generate_dir_root )
          ary.set_files File.join( *factories_generate_dir_root )

          #---- api

          factories_generate_api_dir_root = factories_generate_dir_root + [ "api" ]

          ary.set_files File.join( *factories_generate_api_dir_root )
          ary.set_files Dir.glob( "#{ factories_generate_api_dir_root.join( "/" ) }/**.rb" ).sort

          # meta_class

          factories_generate_api_meta_class_dir_root = factories_generate_api_dir_root + [ "meta_class" ]

          [
            [ "info" ] ,
            [ "info" , "fundamental" ] ,
            [ "info" , "not_on_the_top_layer" ] ,
            [ "list" ] ,
            [ "list" , "normal" ] ,
            [ "list" , "date" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_generate_api_meta_class_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_generate_api_meta_class_dir_root )

          # station_facility

          factories_generate_api_station_facility_dir_root = factories_generate_api_dir_root + [ "station_facility" ]

          [
            [ "info" ] ,
            [ "info" , "barrier_free" ] ,
            [ "info" , "barrier_free" , "info" ] ,
            [ "info" , "barrier_free" , "info" , "service_detail" ] ,
            [ "info" , "barrier_free" , "info" , "service_detail" , "info" ] ,
            [ "info" , "platform" ] ,
            [ "info" , "platform" , "info" ] ,
            [ "info" , "platform" , "info" , "barrier_free_and_surrounding_area" ] ,
            [ "info" , "platform" , "info" , "barrier_free_and_surrounding_area" , "info" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_generate_api_station_facility_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_generate_api_station_facility_dir_root )

          #---- static

          factories_generate_static_dir_root = factories_generate_dir_root + [ "static" ]

          ary.set_files File.join( *factories_generate_static_dir_root )

          # meta_class

          factories_generate_static_meta_class_dir_root = factories_generate_static_dir_root + [ "meta_class" ]

          ary.set_files File.join( *factories_generate_static_meta_class_dir_root )

          ary.set_files File.join( *factories_generate_static_meta_class_dir_root , "group" )

          [
            [ "group" , "fundamental" ] ,
            [ "group" , "multiple_yamls" ] ,
            [ "group" , "hash_in_hash" ] ,
          ].each do | dir_name |
            ary.set_files_starting_with( factories_generate_static_meta_class_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_generate_static_meta_class_dir_root )

          # color

          ary.set_files_starting_with( factories_generate_static_dir_root , "color" )

          # train_type

          [
            [] ,
            [ "color" ] ,
            [ "custom" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_generate_static_dir_root , "train_type" , *dir_name )
          end

          [ "other_operator" , "default_setting" , "main" ].each do | custom_train_type_class |
            ary.set_files_starting_with( factories_generate_static_dir_root , "train_type" , "custom" , custom_train_type_class )
          end

          #---- All

          ary.set_files_starting_with( factories_generate_dir_root )
        end

        def set_factories_for_get( ary , factories_get_dir_root )
          ary.set_files File.join( *factories_get_dir_root )

          factories_get_api_dir_root = factories_get_dir_root + [ "api" ]

          ary.set_files File.join( *factories_get_api_dir_root )

          [
            [ "meta_class" ] ,
            [ "meta_class" , "fundamental" ] ,
            [ "meta_class" , "data_search" ] ,
            [ "meta_class" , "geo" ]
          ].each do | dir_name |
          ary.set_files File.join( *factories_get_api_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_get_api_dir_root )
        end

        def set_factories_for_yaml_station_list( ary , factories_yaml_station_list_dir_root )
          ary.set_files_starting_with( factories_yaml_station_list_dir_root )
        end

        #---- save
        def set_factories_for_save( ary , factories_save_dir_root )
          ary.set_files File.join( *factories_save_dir_root )

          factories_save_api_dir_root = factories_save_dir_root + [ "api" ]

          ary.set_files File.join( *factories_save_api_dir_root )

          [
            [ "meta_class" ] ,
            [ "meta_class" , "each_file" ] ,
            [ "meta_class" , "each_file" , "fundamental" ] ,
            [ "meta_class" , "each_file" , "data_search" ] ,
            [ "meta_class" , "group" ] ,
            [ "meta_class" , "group" , "file_info" ] ,
            [ "meta_class" , "group" , "list" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_save_api_dir_root , *dir_name )
          end

          ary.set_files_starting_with( *factories_save_api_dir_root , "meta_class" , "group" , "file_info" )

          #-------- save_realtime_infos / リアルタイム情報の取得
          ary.set_files File.join( factories_save_api_dir_root , "realtime_infos" )

          ary.set_files_starting_with( factories_save_api_dir_root )
        end

        def set_factories_for_scss( ary , factories_scss_dir_root )
          ary.set_files File.join( *factories_scss_dir_root )

          [ "fundamental" , "colors" , "train_type" ].each do | filename |
            ary.set_files File.join( *factories_scss_dir_root , filename )
          end

          [ "operators" , "railway_lines" , "train_types" ].each do | namespace |
            each_namespace_root = factories_scss_dir_root + [ namespace ]
            ary.set_files File.join( *each_namespace_root )
            [ "dirname_settings" , "fundamental" , "colors" ].each do | filename |
              dir_root = each_namespace_root + [ filename ]
              ary.set_files Dir.glob( "#{ dir_root.join( "/" ) }.rb" ).sort
            end
          end
        end

        #---------------- seed / DB への流し込み
        def set_factories_for_seed( ary , factories_seed_dir_root )
          ary.set_files File.join( *factories_seed_dir_root )

          set_factories_for_seed_reference( ary , factories_seed_dir_root + [ "reference" ] )
          set_factories_for_seed_common( ary , factories_seed_dir_root + [ "common" ] )
          set_factories_for_seed_api( ary , factories_seed_dir_root + [ "api" ] )
          set_factories_for_seed_static( ary , factories_seed_dir_root + [ "static" ] )

          ary.set_files_starting_with( factories_seed_dir_root )
        end

        # reference
        def set_factories_for_seed_reference( ary , factories_seed_reference_dir_root )
          [
            [] ,
            [ "station" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_reference_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_seed_reference_dir_root )
        end

        # common
        def set_factories_for_seed_common( ary , factories_seed_common_dir_root )
          [
            [] ,
            [ "set_optional_variables" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_common_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_seed_common_dir_root )
        end

        # api
        def set_factories_for_seed_api( ary , factories_seed_api_dir_root )
          ary.set_files File.join( *factories_seed_api_dir_root )

          # meta_class/timetables

          factories_seed_api_meta_class_dir_root = factories_seed_api_dir_root + [ "meta_class" ]
          factories_seed_api_meta_class_timetables_dir_root = factories_seed_api_meta_class_dir_root + [ "timetables" ]

          ary.set_files File.join( *factories_seed_api_meta_class_dir_root )
          ary.set_files File.join( *factories_seed_api_meta_class_timetables_dir_root )

          [
            [ "train_type_modules" ] ,
            [ "train_type" ]
          ].each do | dir_name |
            ary.set_files_starting_with( factories_seed_api_meta_class_timetables_dir_root , *dir_name )
          end

          ary.set_files File.join( *factories_seed_api_meta_class_timetables_dir_root , "train_type" )

          ary.set_files_starting_with( factories_seed_api_meta_class_dir_root )

          # station

          factories_seed_api_station_dir_root = factories_seed_api_dir_root + [ "station" ]

          [
            [] ,
            [ "common" ] ,
            [ "info" ] ,
            [ "info" , "common" ] ,
            [ "info" , "common" , "optional_variables" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_api_station_dir_root , *dir_name )
          end

          # station_facility

          factories_seed_api_station_facility_dir_root = factories_seed_api_dir_root + [ "station_facility" ]

          [
            [] ,
            [ "list" ] ,
            [ "list" , "common" ] ,
            [ "info" ] ,
            [ "info" , "common" ] ,
            [ "info" , "common" , "set_optional_variables" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_api_station_facility_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_seed_api_station_facility_dir_root , "info" , "common" )

          [
            [ "info" , "barrier_free" ] ,
            [ "info" , "barrier_free" , "info" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_api_station_facility_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_seed_api_station_facility_dir_root , "info" , "barrier_free" , "service_detail" )

          [
            [ "info" , "barrier_free" , "list" ] ,
            [ "info" , "platform" ] ,
            [ "info" , "platform" , "info" ] ,
            [ "info" , "platform" , "info" , "common" ] ,
            [ "info" , "platform" , "info" , "common" , "set_optional_variables" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_api_station_facility_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_seed_api_station_facility_dir_root , "info" , "platform" , "info" , "common" )

          [
            [ "timetable_infos" ] ,
            [ "timetable_infos" , "train_type_modules" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_api_dir_root , *dir_name )
          end

          # station_timetable

          factories_seed_api_station_timetable_dir_root = factories_seed_api_dir_root + [ "station_timetable" ]

          [
            [] ,
            [ "common" ] ,
            [ "info" ] ,
            [ "info" , "fundamental" ] ,
            [ "info" , "fundamental" , "common" ] ,
            [ "info" , "fundamental" , "list" ]
          ].each do | dir_name |
            ary.set_files File.join( factories_seed_api_station_timetable_dir_root , *dir_name )
          end

          # train_timetable

          factories_seed_api_train_timetable_dir_root = factories_seed_api_dir_root + [ "train_timetable" ]

          [
            [] ,
            [ "common" ] ,
            [ "info" ] ,
            [ "info" , "station_time" ] ,
            [ "info" , "station_time" , "info" ] ,
            [ "info" , "station_time" , "info" , "train_relation" ] ,
            [ "info" , "station_time" , "info" , "train_relation" , "meta_class" ] ,
            [ "info" , "station_time" , "info" , "train_relation" , "meta_class" , "optional_infos" ] ,
            [ "info" , "station_time" , "info" , "train_relation" , "meta_class" , "list" ] ,
            [ "info" , "station_time" , "info" , "train_relation" , "meta_class" , "info" ]
          ].each do | dir_name |
            ary.set_files File.join( factories_seed_api_train_timetable_dir_root , *dir_name )
          end

          # All

          ary.set_files_starting_with( factories_seed_api_dir_root )
        end

        # static
        def set_factories_for_seed_static( ary , factories_seed_static_dir_root )
          ary.set_files File.join( *factories_seed_static_dir_root )
          ary.set_files_starting_with( factories_seed_static_dir_root , "meta_class" )

          # station

          factories_seed_static_station_dir_root = factories_seed_static_dir_root + [ "station" ]

          [
            [] ,
            [ "optional_variables" ]
          ].each do | dir_name |
            ary.set_files File.join( *factories_seed_static_station_dir_root , *dir_name )
          end

          ary.set_files_starting_with( factories_seed_static_dir_root , "operator" )
          ary.set_files_starting_with( factories_seed_static_dir_root , "railway_line" )
          ary.set_files_starting_with( factories_seed_static_dir_root , "station" )

          # All
          ary.set_files_starting_with( factories_seed_static_station_dir_root )
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

      # ::TokyoMetro.set_api_consts( { station_facility: true , passenger_survey: true , station: true , railway_line: true , point: true })

      # ::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )
      # ::TokyoMetro.set_api_constants( { station_timetable: true } )
      # ::TokyoMetro.set_api_constants( { train_timetable: true } )

      # ::TokyoMetro.set_all_api_constants_without_fare
      # ꇐ
      # ::TokyoMetro.set_all_api_constants

      ::ActiveRecord::Base.logger = nil
    end

  end
end

__END__

TokyoMetro::Api::StationTrainTime.seed( :ginza )

TokyoMetro::Factories::Seed.destroy_all_items_of( ::StationTrainTime )

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

::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )
::TokyoMetro.set_api_constants( { station_timetable: true } )

puts ::TokyoMetro::Api.station_timetables.select { | item | /NakanoSakaue/ =~ item.same_as }.map { | item | item.same_as }.sort
puts ""
puts ::TokyoMetro::Api.station_timetables.select { | item | item.at_nakano_sakaue? }.map { | item | item.same_as }.sort

#--------

::TokyoMetro::Api.station_timetables.each do | item |
  ::TokyoMetro::Factories::Api::Seed::TimetableInfos::StationTrainTime::TrainInStationTimetable::StationTimetableInfo.new( item )
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

__END__

完了 - Errorありの可能性
::TokyoMetro::Api::StationTrainTime.seed( :ginza )
::TokyoMetro::Api::StationTrainTime.seed( :hibiya )
::TokyoMetro::Api::StationTrainTime.seed( :tozai )
::TokyoMetro::Api::StationTrainTime.seed( :namboku )

完了
::TokyoMetro::Api::StationTrainTime.seed( :hanzomon )
::TokyoMetro::Api::StationTrainTime.seed( :yurakucho_fukutoshin )
::TokyoMetro::Api::StationTrainTime.seed( :chiyoda )

完了 - Check 前

実行中

未完了
::TokyoMetro::Api::StationTrainTime.seed( :marunouchi_including_branch )

#--------

TokyoMetro::Api::StationTrainTime.check_number( :ginza )
TokyoMetro::Api::StationTrainTime.check_number( :hibiya )
TokyoMetro::Api::StationTrainTime.check_number( :tozai )
TokyoMetro::Api::StationTrainTime.check_number( :chiyoda )
TokyoMetro::Api::StationTrainTime.check_number( :hanzomon )
TokyoMetro::Api::StationTrainTime.check_number( :namboku )
TokyoMetro::Api::StationTrainTime.check_number( :yurakucho , :fukutoshin )
TokyoMetro::Api::StationTrainTime.check_number( :marunouchi , :marunouchi_branch )

#--------

TokyoMetro::Api::StationTrainTime.destory( :marunouchi , :marunouchi_branch )

#--------

# ary = TokyoMetro::Api::TrainLocation::generate_from_saved_json( 2014 , 10 , 6 , line: "Ginza" , max: 100 )

__END__

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

def change_train_timetable_infos_of_marunouchi
  marunouchi_ids = ::RailwayLine.where( same_as: [ "odpt.Railway:TokyoMetro.Marunouchi" , "odpt.Railway:TokyoMetro.MarunouchiBranch" ] ).pluck( :id )
  train_timetable_ids = ::TrainTimetable.where( railway_line_id: marunouchi_ids ).pluck( :id )
  puts train_timetable_ids.length
  a = gets.chomp
  train_timetable_ids.each do | train_timetable_id |
    d = ::TrainTimetable.find( train_timetable_id )
    d.destroy
  end
  puts "[Destroy] Completed"
  a = gets.chomp

  ::TokyoMetro::Api.train_timetables.marunouchi_including_branch.seed
  return nil
end