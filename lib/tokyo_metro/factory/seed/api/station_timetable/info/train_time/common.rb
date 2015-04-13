module TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Common

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 3 )
    @station_timetable_info , @operation_day_in_db , @train_timetables = args
  end

  def optional_variables
    [ @station_timetable_info , @operation_day_in_db , @train_timetables ]
  end

end