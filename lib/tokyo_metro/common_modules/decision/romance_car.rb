module TokyoMetro::CommonModules::Decision::RomanceCar

  def romance_car_on_chiyoda_line?
    chiyoda_line? and limited_express_or_romance_car?
  end

end