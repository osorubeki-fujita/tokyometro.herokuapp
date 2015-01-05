# 保存済みの列車運行情報 odpt:TrainInformation を処理する Factory Pattern のクラス
class TokyoMetro::Factories::Api::GenerateFromSavedFile::TrainInformation < TokyoMetro::Factories::Api::GenerateFromSavedFile::MetaClass::Date
  include ::TokyoMetro::ClassNameLibrary::Api::TrainInformation
end