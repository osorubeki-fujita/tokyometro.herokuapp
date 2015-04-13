class TokyoMetro::Factory::Seed::Static::TrainType::Custom::Main::Hash < TokyoMetro::Factory::Seed::Static::Operator::Hash

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main

  def seed_instance_for_escaping_undefined
    train_type_in_api = ::TrainTypeInApi.find_by( same_as: "odpt.TrainType:TokyoMetro.Unknown" )

    h = {
      same_as: "custom.TrainTypeUndefined" ,
      note: "未定義" ,
      train_type_in_api_id: train_type_in_api.id ,
      railway_line_id: ::RailwayLine.find_by_name_ja( "未定義" )
    }
    ::TrainType.find_or_create_by(h)
  end

end