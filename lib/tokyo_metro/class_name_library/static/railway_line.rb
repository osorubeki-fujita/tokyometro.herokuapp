# 路線の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::RailwayLine

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::Static::RailwayLine
    end

    # ハッシュのクラス
    # @return [Const (class name)]
    def hash_class
      ::TokyoMetro::Static::RailwayLine::Hash
    end

    # ハッシュの値のクラス
    # @return [Const (class name)]
    def info_class
      ::TokyoMetro::Static::RailwayLine::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::RailwayLine::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::RailwayLine::Info
    end

    def factory_for_seeding_hash
      ::TokyoMetro::Factory::Seed::Static::RailwayLine::Hash
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Static::RailwayLine::Info
    end

    def db_instance_class
      ::RailwayLine
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    def scss_color_factory
      ::TokyoMetro::Factory::Scss::RailwayLines::Colors
    end

    private

    def yaml_file_basename
      "railway_line"
    end

  end

  private

  # 書き出すファイルの名称
  # @note HAML ファイル等で使用
  # @return [String (filename)]
  def filename_base
    "railway_lines"
  end

end