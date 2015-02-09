module TokyoMetro::Factories::Seed::Api::StationTimetable::Info::Fundamental::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 5
    @station_timetable_id , @operators , @railway_lines , @stations , @railway_directions = variables
  end

  def optional_variables
    [ @station_timetable_id , @operators , @railway_lines , @stations , @railway_directions ]
  end

end