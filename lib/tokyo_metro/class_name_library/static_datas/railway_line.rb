# 路線の情報を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::StaticDatas::RailwayLine

  extend ::ActiveSupport::Concern

  module ClassMethods

    def toplevel_namespace
      ::TokyoMetro::StaticDatas::RailwayLine
    end

    # ハッシュのクラス
    # @return [Const (class name)]
    def hash_class
      ::TokyoMetro::StaticDatas::RailwayLine::Hash
    end

    # ハッシュの値のクラス
    # @return [Const (class name)]
    def info_class
      ::TokyoMetro::StaticDatas::RailwayLine::Info
    end

    def factory_class
      ::TokyoMetro::Factories::StaticDatas::RailwayLine
    end

    # SCCS の color ファイルを作成する Factory Pattern Class の名称を返すメソッド
    # @return [Const (class)]
    def scss_color_factory
      ::TokyoMetro::Factories::Scss::RailwayLines::Colors
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