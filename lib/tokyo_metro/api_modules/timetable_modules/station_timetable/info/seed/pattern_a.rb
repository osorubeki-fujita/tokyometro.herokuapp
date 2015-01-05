module TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::PatternA

  def seed( operators , railway_lines , stations , railway_directions , whole: nil , now_at: nil , indent: 0 )
    seed_common( operators , railway_lines , stations , railway_directions , whole: whole , now_at: now_at , indent: indent ) do
      seed_train_times
    end
  end

  private

  def seed_train_times
    combination_of_timetable_types_and_operation_days.each do | trains , operation_day |
      operation_day_id = ::TokyoMetro::Seed::OperationDayProcesser.find_or_create_by_and_get_ids_of( operation_day ).first
      operation_day_instance = ::OperationDay.find_by_id( operation_day_id )
      trains.seed( instance_in_db.id , operation_day_instance , railway_line_instance , station_instance )
    end
  end

end