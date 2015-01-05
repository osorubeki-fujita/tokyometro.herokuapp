# 保存済みの駅情報 odpt:Station を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::Station < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::Station
end