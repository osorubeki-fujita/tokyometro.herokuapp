namespace :temp do
  task :update_train_type_in_apis_20150711 => :environment do
    train_type_in_api_holiday_express = ::Train::Type::InApi.find_by( same_as: "odpt.TrainType:TokyoMetro.RomanceCar" )
    raise unless train_type_in_api_holiday_express.present?
    train_type_in_api_holiday_express.update( name_en: "Limited Express \"Romance Car\"" , name_en_short: nil )
  end

  task :update_railway_line_undefined_20150711 => :environment do
    railway_line_undefined = ::RailwayLine.find_by( same_as: "odpt.Railway:Undefined" )
    raise unless railway_line_undefined.present?
    railway_line_undefined.update(
      name_ja_normal: "未定義" , name_ja_with_operator_name_precise: "未定義" , name_ja_with_operator_name: "未定義" ,
      name_en_normal: "Undefined" , name_en_with_operator_name_precise: "Undefined" , name_en_with_operator_name: "Undefined"
    )
  end
end
