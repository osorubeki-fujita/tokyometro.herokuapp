module TokyoMetro::Factories::Seed::Api::Station::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 3
    @operators , @railway_lines , @station_facilities = variables
  end

  def optional_variables
    [ @operators , @railway_lines , @station_facilities ]
  end

end