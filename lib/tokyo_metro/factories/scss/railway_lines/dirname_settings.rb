# 路線情報に関する SCSS のディレクトリ情報を提供するモジュール
module TokyoMetro::Factories::Scss::RailwayLines::DirnameSettings

  extend ::ActiveSupport::Concern

  # モジュールが include されたクラスに対し、ActiveSupport::Concern によってクラスメソッドとして組み込まれるメソッドを集めたモジュール
  module ClassMethods

    private

    def scss_dir
      "railway_lines"
    end

    alias :css_dir :scss_dir

  end

end