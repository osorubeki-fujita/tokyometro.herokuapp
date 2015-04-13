# 列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::TrainType::Custom::Main
    end

    def hash_class
      ::TokyoMetro::Static::TrainType::Custom::Main::Hash
    end

    def info_class
      ::TokyoMetro::Static::TrainType::Custom::Main::Info
    end

    def factory_for_generating_from_saved_files
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::Main::Hash
    end

    def factory_for_generating_from_each_saved_file
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::Main::Hash::EachFile
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::TrainType::Custom::Main::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factory::Seed::Static::TrainType::Custom::Main::Hash
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::TrainType::Custom::Main::Info
    end

    def db_instance_class
      ::TrainType
    end

    # タイトル
    # @note Haml ファイルに書き出す際の見出しなどに使用
    # @return [String]
    def title_ja
      "列車種別"
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    # @note おそらく、もう使うことはない。
    # @todo 削除？
    def scss_color_factory
      ::TokyoMetro::Factory::Scss::TrainTypes::Colors
    end

    # Hash のインスタンスを作成するときに必要な YAML ファイルのリスト
    # @return [::Array <String (filename)>]
    def yaml_files
      yaml_files_of_tokyo_metro + yaml_files_of_toei
    end

    private

    def yaml_files_of_tokyo_metro
      dir_name = "#{::TokyoMetro::dictionary_dir}/train_type/tokyo_metro"

      # YAML ファイルは以下のリストに含まれているものがすべて
      # 過不足がある場合はエラーとする。
      valid_yaml_files = %W( ginza marunouchi hibiya tozai chiyoda chiyoda_romance_car hanzomon namboku yurakucho_fukutoshin )

      yaml_files_sorted( dir_name , valid_yaml_files )
    end

    def yaml_files_of_toei
      dir_name = "#{::TokyoMetro::dictionary_dir}/train_type/toei"

      # YAML ファイルは以下のリストに含まれているものがすべて
      # 過不足がある場合はエラーとする。
      valid_yaml_files = %W( asakusa mita shinjuku oedo )

      yaml_files_sorted( dir_name , valid_yaml_files )
    end

    def yaml_files_sorted( dir_name , valid_yaml_files )
      yaml_files = Dir.glob( "#{ dir_name }/**.yaml" )
      check_validity_of_yaml_files( yaml_files , valid_yaml_files )
      yaml_files.sort_by { | filename | valid_yaml_files.index( File.basename( filename , ".*" ) ) }
    end

    def check_validity_of_yaml_files( yaml_files , valid_yaml_files )
      yaml_files_sorted = yaml_files.sort
      valid_yaml_files_sorted = valid_yaml_files.sort

      unless yaml_files.map { | filename | File.basename( filename , ".*" ) }.sort == valid_yaml_files_sorted
        puts "● yaml_files"
        puts yaml_files_sorted
        puts ""
        puts "○ valid_yaml_files"
        puts valid_yaml_files
        puts ""
        included_in_yaml_file_list = ( yaml_files_sorted - valid_yaml_files_sorted )
        included_in_valid_yaml_file_list = ( valid_yaml_files_sorted - yaml_files_sorted )

        puts "※ Difference"

        if included_in_yaml_file_list.present?
          puts " " * 2 + "Included in yaml file list"
          included_in_yaml_file_list.each do | item |
            puts " " * 2 + item
          end
        end

        if included_in_valid_yaml_file_list.present?
          puts " " * 2 + "Included in valid yaml file list"
          included_in_valid_yaml_file_list.each do | item |
            puts " " * 2 + item
          end
        end

        raise "Error"
      end

    end

  end

  private

  # 書き出すファイルの名称
  # @note HAML ファイル等で使用
  # @return [String (filename)]
  def filename_base
    "train_types"
  end

end