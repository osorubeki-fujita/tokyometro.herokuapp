module TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Seed::Common

  private

  def seed_common( operators , railway_lines , stations , railway_directions , whole: nil , now_at: nil , indent: 0 )
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ , indent: indent , other: @same_as , whole: whole , now_at: now_at )
    time_begin = Time.now

    operator_instance = operators.find_by( same_as: @operator )
    railway_line_instance = railway_lines.find_by( same_as: @railway_line )
    station_instance = stations.find_by( same_as: @station )
    railway_direction_instance = railway_directions.find_by( in_api_same_as: @railway_direction , railway_line_id: railway_line_instance.id )

    seed_h = {
      id_urn: @id_urn ,
      same_as: @same_as ,
      dc_date: @date ,
      operator_id: operator_instance.id ,
      railway_line_id: railway_line_instance.id ,
      station_id: station_instance.id ,
      railway_direction_id: railway_direction_instance.id
    }
    ::Timetable.create( seed_h )

    if block_given?
      yield
    end
    ::TokyoMetro::Seed::Inspection.time( time_begin , indent: indent )
  end

end