module TokyoMetro::Factory::Seed::Api::TrainTimetable::Common

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 5 )
    @operators , @railway_lines , @stations , @railway_directions , @train_owners = args
  end

  def optional_variables
    [ @operators , @railway_lines , @stations , @railway_directions , @train_owners ]
  end

end