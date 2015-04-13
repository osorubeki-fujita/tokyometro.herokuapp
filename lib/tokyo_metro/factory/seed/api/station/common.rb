module TokyoMetro::Factory::Seed::Api::Station::Common

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 3 )
    @operators , @railway_lines , @station_facilities = args
  end

  def optional_variables
    [ @operators , @railway_lines , @station_facilities ]
  end

end