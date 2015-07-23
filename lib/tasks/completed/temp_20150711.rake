namespace :temp do
  namespace :completed do

    task :update_train_type_in_apis_20150711 => :environment do
      train_type_in_api_holiday_express = ::Train::Type::InApi.find_by( same_as: "odpt.TrainType:TokyoMetro.RomanceCar" )
      raise unless train_type_in_api_holiday_express.present?
      train_type_in_api_holiday_express.update( name_en: "Limited Express \"Romance Car\"" , name_en_short: nil )
    end

    task :update_railway_line_undefined_20150711 => :environment do
      railway_line_undefined = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:Undefined" )
      raise unless railway_line_undefined.present?
      railway_line_undefined.update(
        name_ja_normal: "未定義" , name_en_normal: "Undefined"
      )
    end

  end
end
