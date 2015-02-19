module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::FukutoshinLineForWakoshi::Info

  def initialize( *variables )
    super( *variables )
    convert_terminal_stations_of_fukutoshin_line_for_wakoshi
  end

  private

  def convert_terminal_stations_of_fukutoshin_line_for_wakoshi
    if fukutoshin_line? and between_wakoshi_and_kotake_mukaihara?
      convert_terminal_stations( :convert_terminal_station_to_wakoshi_in_fukutoshin_line )
    end
  end

end