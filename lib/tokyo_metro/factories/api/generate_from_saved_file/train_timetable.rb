# 保存済みの列車時刻表 odpt:TrainTimetable を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainTimetable < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
end