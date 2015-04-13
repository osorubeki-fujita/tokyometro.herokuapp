module TokyoMetro::Factory::Seed::Reference::Dictionary::TrainType

  private

  def romance_car
    ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal" )
  end

  def hanzomon_line_holiday_express_to_tokyu_den_en_toshi_line_stopping_at_minami_machida
    ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Hanzomon.HolidayExpress.ToTokyu" )
  end

  def toei_mita_line_local_train_normal
    ::TrainType.find_by_same_as( "custom.TrainType:Toei.Mita.Local.Normal" )
  end

  def toei_mita_line_local_train_to_tokyu
    ::TrainType.find_by_same_as( "custom.TrainType:Toei.Mita.Local.ToTokyu" )
  end

  def toei_mita_line_express_train_to_tokyu
    ::TrainType.find_by_same_as( "custom.TrainType:Toei.Mita.Express.ToTokyu" )
  end

end