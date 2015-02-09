module TokyoMetro::Factories::Seed::Api::StationTimetable::Info::TrainTime::Common

  private

  def set_optional_variables( variables )
    raise "Error" unless variables.length == 3
    @station_timetable_info , @operation_day_in_db , @train_timetables = variables
  end

  def optional_variables
    [ @station_timetable_info , @operation_day_in_db , @train_timetables ]
  end

end