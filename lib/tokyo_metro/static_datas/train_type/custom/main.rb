# 列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラス
class TokyoMetro::StaticDatas::TrainType::Custom::Main < TokyoMetro::StaticDatas::Fundamental::MetaClass::UsingMultipleYamls
  include TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::Main
end

# main/info.rb
# main/hash.rb