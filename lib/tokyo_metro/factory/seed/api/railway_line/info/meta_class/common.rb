module TokyoMetro::Factory::Seed::Api::RailwayLine::Info::MetaClass::Common

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @railway_line_id = args.first
  end

  def optional_variables
    [ @railway_line_id ]
  end

end