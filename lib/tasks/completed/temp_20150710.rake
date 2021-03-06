namespace :temp do
  namespace :completed do

    task :update_train_type_infos_20150710 => :environment do
      # train_type_undefined = ::Train::Type::Info.find_by( same_as: "custom.TrainTypeUndefined" )
      # raise unless train_type_undefined.present?
      # train_type_undefined.update( same_as: "custom.TrainType:Undefined" )

      train_type_holiday_express_on_den_en_toshi_line = ::Train::Type::Info.find_by( same_as: "custom.TrainType:TokyoMetro.Hanzomon.HolidayExpress.ToTokyu" )
      raise unless train_type_holiday_express_on_den_en_toshi_line.present?
      train_type_holiday_express_on_den_en_toshi_line.update( bgcolor: "#ff99cc" )

      train_type_holiday_express_on_fukutoshin_line = ::Train::Type::Info.find_by( same_as: "custom.TrainType:TokyoMetro.Fukutoshin.HolidayExpress.Normal" )
      raise unless train_type_holiday_express_on_fukutoshin_line.present?
      train_type_holiday_express_on_fukutoshin_line.update( bgcolor: "#ff99cc" )
    end

  end
end
