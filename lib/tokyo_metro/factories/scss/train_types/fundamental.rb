# 列車種別の情報に関する SCSS の fundamental ファイルを処理するための Factory Pattern Class
# @note 廃止
class TokyoMetro::Factories::Scss::TrainTypes::Fundamental < TokyoMetro::Factories::Scss::Fundamental
  include ::TokyoMetro::Factories::Scss::TrainTypes::DirnameSettings
end