# 鉄道事業者の情報に関する SCSS の color ファイルを作成・処理するための Factory Pattern Class
class TokyoMetro::Factories::Scss::Operators::Colors < TokyoMetro::Factories::Scss::Colors

  include ::TokyoMetro::Factories::Scss::Operators::DirnameSettings

  # SCSS ファイルを作成する際の設定
  # @return [Hash]
  def self.settings_of_method_name
    { bgcolor: :web_color }
  end

end