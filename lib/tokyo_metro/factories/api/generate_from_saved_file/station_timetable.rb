# 保存済みの駅時刻表 odpt:StationTimetable を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::StationTimetable < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
end