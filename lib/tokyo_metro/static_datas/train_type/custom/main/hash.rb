# 複数の列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラス（ハッシュ）
class TokyoMetro::StaticDatas::TrainType::Custom::Main::Hash < TokyoMetro::StaticDatas::Operator::Hash

  include TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::Main
  include ::TokyoMetro::StaticDataModules::Hash::Seed

  def seed_instance_for_escaping_undefined
    train_type_in_api = ::TrainTypeInApi.find_by( same_as: "odpt.TrainType:TokyoMetro.Unknown" )

    h = {
      same_as: "custom.TrainTypeUndefined" ,
      note: "未定義" ,
      train_type_in_api_id: train_type_in_api.id ,
      railway_line_id: ::RailwayLine.find_by_name_ja( "未定義" )
    }
    ::TrainType.create(h)
  end

end