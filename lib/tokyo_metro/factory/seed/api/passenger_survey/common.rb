module TokyoMetro::Factory::Seed::Api::PassengerSurvey::Common

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @operators = args.first
  end

  def optional_variables
    [ @operators ]
  end

end