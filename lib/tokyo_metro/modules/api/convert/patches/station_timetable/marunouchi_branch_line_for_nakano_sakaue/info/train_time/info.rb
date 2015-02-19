module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::MarunouchiBranchLineForNakanoSakaue::Info::TrainTime::Info

  def convert_terminal_station_to_nakano_sakaue_in_marunouchi_branch_line
    convert_terminal_station( *( ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.nakano_sakaue ) )
  end

end