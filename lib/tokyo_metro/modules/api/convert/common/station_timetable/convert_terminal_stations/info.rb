module TokyoMetro::Modules::Api::Convert::Common::StationTimetable::ConvertTerminalStations::Info

  private

  def convert_terminal_stations( method_name_send_to_train_time )
    self.timetables.each do | timetable |
      timetable.each do | train_time |
        train_time.send( method_name_send_to_train_time )
      end
    end
  end

end