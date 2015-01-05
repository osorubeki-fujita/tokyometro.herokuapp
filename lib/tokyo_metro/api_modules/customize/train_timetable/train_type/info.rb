module TokyoMetro::ApiModules::Customize::TrainTimetable::TrainType::Info

  def initialize( id_urn , same_as , dc_date , train_number , railway_line , operator , train_type , railway_direction ,
    starting_station , terminal_station , train_owner , weekdays , saturdays , holidays
  )
    super
    convert_romance_car_on_chiyoda_line
  end

  private

  def convert_romance_car_on_chiyoda_line
    if romance_car_on_chiyoda_line?
      @train_type = "odpt.TrainType:TokyoMetro.RomanceCar"
    end
  end

end