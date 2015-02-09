module TokyoMetro::Factories::Seed::Api::StationTimetable::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 4
    @operators , @railway_lines , @stations , @railway_directions = variables
  end

  def optional_variables
    [ @operators , @railway_lines , @stations , @railway_directions ]
  end

end