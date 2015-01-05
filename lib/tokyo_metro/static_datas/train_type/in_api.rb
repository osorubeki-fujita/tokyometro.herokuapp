# API で定義されている列車種別情報を扱うクラス
module TokyoMetro::StaticDatas::TrainType::InApi

  include ::TokyoMetro::StaticDataModules::ToFactory::GenerateFromOneYaml

  def self.factory_class
    ::TokyoMetro::Factories::StaticDatas::TrainType::Api
  end

end