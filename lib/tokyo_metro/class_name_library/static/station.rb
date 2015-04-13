# 駅の情報（他社線も含む）を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::Station

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::Station
    end

    def hash_class
      ::TokyoMetro::Static::Station::RailwayLines
    end

    def subhash_class
      ::TokyoMetro::Static::Station::InEachRailwayLine
    end

    def info_class
      ::TokyoMetro::Static::Station::InEachRailwayLine::Info
    end

    def factory_for_generating_from_saved_files
      ::TokyoMetro::Factory::Generate::Static::Station::RailwayLines
    end

    def factory_for_generating_from_each_saved_file
      ::TokyoMetro::Factory::Generate::Static::Station::InEachRailwayLine
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::Station::InEachRailwayLine::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factory::Seed::Static::Station::RailwayLines
    end

    def factory_for_seeding_subhash
      ::TokyoMetro::Factory::Seed::Static::Station::InEachRailwayLine
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::Station::Info
    end

    def db_instance_class
      ::Station
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    # @note おそらく、もう使うことはない。
    def scss_color_factory
      ::TokyoMetro::Factory::Scss::Station::Colors
    end

    # タイトル
    # @note Haml ファイルに書き出す際の見出しなどに使用
    # @return [String]
    def title_ja
      "駅一覧"
    end

    private

    # Hash のインスタンスを作成するときに必要な YAML ファイルのリスト
    # @return [::Array <String (filename)>]
    def yaml_files

      h = Hash.new
      hash_for_making_file_list.each do | key , value |
        h[ key ] = "#{topdir_of_station_dictionary}/#{ value.join( "\/" ) }.yaml"
      end
      h_values = h.values.sort

      files = yaml_files_in_station_dictionary_dirs

      unless h_values == files
        puts "● Hash"
        puts h_values
        puts ""
        puts "○ File"
        puts files
        puts ""
        included_in_values_of_hash = ( h_values - files )
        included_in_file_list = ( files - h_values )

        puts "※ Difference"

        if included_in_values_of_hash.present?
          puts " " * 2 + "Included in values of hash"
          included_in_values_of_hash.each do | item |
            puts " " * 2 + item
          end
        end

        if included_in_file_list.present?
          puts " " * 2 + "Included in file list"
          included_in_file_list.each do | item |
            puts " " * 2 + item
          end
        end

        raise "Error"
      end
      h
    end

    def hash_for_making_file_list
      ::YAML.load_file( "#{topdir_of_station_dictionary}/file_list.yaml" )
    end

    def yaml_files_in_station_dictionary_dirs
      subdirs_of_station_dictionary.map { | dirname |
        "#{topdir_of_station_dictionary}/#{dirname}"
      }.map { | dirname |
        Dir.glob( "#{dirname}/**/**.yaml" )
      }.flatten.sort
    end

    def topdir_of_station_dictionary
      "#{ ::TokyoMetro::dictionary_dir }/station"
    end

    def subdirs_of_station_dictionary
      [ "tokyo_metro" , "other_operator" , "appeared_in_connecting_railway_line_info" ]
    end

  end

  private

  # 書き出すファイルの名称
  # @note HAML ファイル等で使用
  # @return [String (filename)]
  def filename_base
    "stations"
  end

end