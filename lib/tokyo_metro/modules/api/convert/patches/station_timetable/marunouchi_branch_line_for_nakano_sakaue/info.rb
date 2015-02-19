module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::MarunouchiBranchLineForNakanoSakaue::Info

  def initialize( *variables )
    super( *variables )
    convert_terminal_stations_of_marunouchi_branch_line_for_nakano_sakaue
  end

  private

  def convert_terminal_stations_of_marunouchi_branch_line_for_nakano_sakaue
    if marunouchi_line_including_branch? and between_honancho_and_nakano_shimbashi_including_invalid?
      convert_terminal_stations( :convert_terminal_station_to_nakano_sakaue_in_marunouchi_branch_line )
    end
  end

end