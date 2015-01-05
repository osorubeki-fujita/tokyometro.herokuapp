module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertTerminalStation::FukutoshinLineForWakoshi::Info

  def initialize( id_urn , same_as , dc_date , station , railway_line , operator , railway_direction , 
    weekdays , saturdays , holidays )
    super
    convert_terminal_station_of_fukutoshin_line_for_wakoshi
  end

  private

  def convert_terminal_station_of_fukutoshin_line_for_wakoshi
    if fukutoshin_line? and between_wakoshi_and_kotake_mukaihara?
      convert_terminal_stations( :convert_terminal_station_to_wakoshi_in_fukutoshin_line )
    end
  end

end