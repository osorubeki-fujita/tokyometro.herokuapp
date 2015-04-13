module TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::OptionalInfos

  def set_optional_infos( *args )
    raise "Error" unless args.length == 2
    @station_train_time_id , @train_timetable_id = args
  end

  def optional_infos
    [ @station_train_time_id , @train_timetable_id ]
  end

end