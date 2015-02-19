module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::MusashiKosugiInNambokuLine::Info

  def initialize( *variables )
    super( *variables )
    convert_terminal_station_of_namboku_line_train_for_musashi_kosugi
  end

  private

  def convert_terminal_station_of_namboku_line_train_for_musashi_kosugi
    if namboku_line?
      convert_terminal_stations( :convert_terminal_station_to_musashi_kosugi_in_tokyu_meguro_line )
    end
  end

end