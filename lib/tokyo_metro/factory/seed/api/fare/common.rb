module TokyoMetro::Factory::Seed::Api::Fare::Common

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 2 )
    @normal_fares , @operators = args
  end

  def optional_variables
    [ @normal_fares , @operators ]
  end

end