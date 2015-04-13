# 駅の情報（名称、管理事業者など）を扱うクラスの名称を提供するモジュール
module TokyoMetro::ClassNameLibrary::Static::StationsInTokyoMetro

  extend ::ActiveSupport::Concern

  module ClassMethods

    def hash_class
      ::TokyoMetro::Static::StationsInTokyoMetro::Hash
    end

    def info_class
      ::TokyoMetro::Static::StationsInTokyoMetro::Info
    end

    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Static::StationsInTokyoMetro::Hash
    end

    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Static::StationsInTokyoMetro::Info
    end

    # タイトル
    # @note Haml ファイルに書き出す際の見出しなどに使用
    # @return [String]
    def title_ja
      "駅施設"
    end

    private

    def yaml_file_basename
      "stations_in_tokyo_metro"
    end

  end

  private

  # 書き出すファイルの名称
  # @note HAML ファイル等で使用
  # @return [String (filename)]
  def filename_base
    "stations_in_tokyo_metro"
  end

end