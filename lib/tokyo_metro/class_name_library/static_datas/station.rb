# 駅の情報（他社線も含む）を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::Station

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::Station
    end

    def hash_class
      ::TokyoMetro::StaticDatas::Station::RailwayLines
    end

    def subhash_class
      ::TokyoMetro::StaticDatas::Station::InEachRailwayLine
    end

    def info_class
      ::TokyoMetro::StaticDatas::Station::InEachRailwayLine::Info
    end

    def toplevel_factory_class
      ::TokyoMetro::Factories::StaticDatas::Station
    end

    def subhash_factory_class
      ::TokyoMetro::Factories::StaticDatas::Station::InEachRailwayLine
    end

    alias :factory_for_each_file :subhash_factory_class

    def factory_class
      ::TokyoMetro::Factories::StaticDatas::Station::RailwayLines
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    # @note おそらく、もう使うことはない。
    def scss_color_factory
      ::TokyoMetro::Factories::Scss::Station::Colors
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
      dirname_of_station_dictionary = "#{ ::TokyoMetro::dictionary_dir }/station"
      list_hash = yaml_files__list_hash_from_file( dirname_of_station_dictionary )
      files = yaml_files__files_in_directory( dirname_of_station_dictionary )

      h = Hash.new
      list_hash.each do | key , value |
        h[ key ] = "#{dirname_of_station_dictionary}/#{ value.join( "\/" ) }.yaml"
      end
      h_values = h.values.sort

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

    def yaml_files__list_hash_from_file( dirname_of_station_dictionary )
      ::YAML.load_file( "#{dirname_of_station_dictionary}/file_list.yaml" )
    end

    def yaml_files__files_in_directory( dirname_of_station_dictionary )
      directories = [ "tokyo_metro" , "other_operator" ].map { | dirname | "#{dirname_of_station_dictionary}/#{dirname}" }
      files = directories.map { | dirname | Dir.glob( "#{dirname}/**/**.yaml" ) }.flatten.sort
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