# 保存済みの駅乗降人員数 odpt:PassengerSurvey の情報を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::PassengerSurvey < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Normal
  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey
end