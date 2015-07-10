namespace :temp do
  task :update_train_types_20150710 => :environment do
    train_type_undefined = ::TrainType.find_by( same_as: "custom.TrainTypeUndefined" )
    raise unless train_type_undefined.present?
    train_type_undefined.update( same_as: "custom.TrainType:Undefined" )

    train_type_holiday_express_on_den_en_toshi_line = ::TrainType.find_by( same_as: "custom.TrainType:TokyoMetro.Hanzomon.HolidayExpress.ToTokyu" )
    raise unless train_type_holiday_express_on_den_en_toshi_line.present?
    train_type_holiday_express_on_den_en_toshi_line.update( bgcolor: "#ff3399" )
  end
end
