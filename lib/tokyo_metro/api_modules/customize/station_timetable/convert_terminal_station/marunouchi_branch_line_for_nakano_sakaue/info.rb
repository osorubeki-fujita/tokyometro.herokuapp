module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::MarunouchiBranchLineForNakanoSakaue::Info

  def initialize( id_urn , same_as , dc_date , station , railway_line , operator , railway_direction , 
    weekdays , saturdays , holidays )
    super
    convert_terminal_station_of_marunouchi_branch_line_for_nakano_sakaue
  end

  private

  def convert_terminal_station_of_marunouchi_branch_line_for_nakano_sakaue
    if marunouchi_line_including_branch? and between_honancho_and_nakano_shimbashi?
      convert_terminal_stations( :convert_terminal_station_to_nakano_sakaue_in_marunouchi_branch_line )
    end
  end

end