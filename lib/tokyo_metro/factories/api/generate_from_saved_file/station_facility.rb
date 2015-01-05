# 保存済みの駅施設情報 odpt:StationFacility を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::StationFacility < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
end