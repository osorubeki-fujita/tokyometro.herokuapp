# 保存済みの路線情報 odpt:Railway を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::RailwayLine < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
end