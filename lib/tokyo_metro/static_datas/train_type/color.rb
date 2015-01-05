# 種別の色を扱うクラス
module TokyoMetro::StaticDatas::TrainType::Color

  include ::TokyoMetro::StaticDataModules::ToFactory::GenerateFromOneYaml

  def self.factory_class
    ::TokyoMetro::Factories::StaticDatas::TrainType::Color
  end

end