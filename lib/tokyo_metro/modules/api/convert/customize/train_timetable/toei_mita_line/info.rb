module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::ToeiMitaLine::Info

  def initialize( *variables )
    super( *variables )
    convert_station_name_of_toei_mita_line
  end

  private

  def convert_station_name_of_toei_mita_line
    if toei_mita_line_train_including_on_namboku_line?
      replace_station_name( ::TokyoMetro::Modules::Api::Convert::Customize::Dictionary::RegexpForReplace.namboku_and_toei_mita_line_common_stations , "Toei.Mita" )
    end
  end

end