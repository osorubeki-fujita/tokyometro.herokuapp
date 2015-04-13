module TokyoMetro::Factory::Seed::Static::Station::OptionalVariables

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @railway_line_id = args.first
  end

end