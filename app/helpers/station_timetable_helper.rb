module StationTimetableHelper

  def make_station_timetables
    content = ::String.new

    class << @station_timetables
      include OdptCommon::StationTimetables::GroupByRailwayLine
    end

    @station_timetables.group_by_railway_line.each do | railway_line_id , station_timetables_of_a_railway_line |
      # 路線別の時刻表（複数）を取得
      railway_line = ::RailwayLine.find_by( id: railway_line_id )
      class <<station_timetables_of_a_railway_line
        include OdptCommon::StationTimetables::GroupByRailwayDirection
      end
      station_timetables_grouped_by_direction = station_timetables_of_a_railway_line.group_by_railway_direction
      railway_direction_ids = station_timetables_grouped_by_direction.keys.sort_by { | railway_direction_id |
        ::RailwayDirection.find_by( id: railway_direction_id ).station_info_id
      }

      railway_direction_ids.each do | railway_direction_id |
        # 方面別の時刻表（1つ）を取得
        station_timetables_of_a_direction = station_timetables_grouped_by_direction[ railway_direction_id ]
        # 【注意】station_timetables_of_a_direction は配列
        unless station_timetables_of_a_direction.length == 1
          raise "Error"
        end
        timetable_of_a_direction = station_timetables_of_a_direction.first

        # RailwayDirection のインスタンスを取得
        railway_direction = ::RailwayDirection.find_by( id: railway_direction_id )

        # 方面ごとの各列車の時刻を取得
        station_train_times_in_a_timetable_of_a_direction = timetable_of_a_direction.station_train_times.includes( :train_timetable , train_timetable: [ :terminal_station_info , :train_type , :operation_day ] )

        # 曜日ごとに仕分け
        station_train_times_in_a_timetable_of_a_direction_grouped_by_operation_days = station_train_times_in_a_timetable_of_a_direction.group_by { | train_time |
          train_time.operation_day.id
        }.sort_keys

        operation_day_ids = station_train_times_in_a_timetable_of_a_direction_grouped_by_operation_days.keys

        operation_day_ids.each do | operation_day_id |
          operation_day = ::OperationDay.find_by( id: operation_day_id )
          station_train_times_of_a_direction_and_an_operation_day = station_train_times_in_a_timetable_of_a_direction_grouped_by_operation_days[ operation_day_id ]

          content << ::TokyoMetro::App::Renderer::StationTimetable.new( @station_info , railway_line , railway_direction , operation_day , station_train_times_of_a_direction_and_an_operation_day ).render

        end
      end
    end
    raw( content )
  end

end