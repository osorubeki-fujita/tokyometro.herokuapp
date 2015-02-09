# 個別の駅の発着時刻情報の配列
class TokyoMetro::Api::TrainTimetable::Info::StationTime::List < TokyoMetro::Api::MetaClass::Fundamental::List

=begin
  # @note {::TokyoMetro::Api::StationTimetable::Info::TrainTime::List#seed} と同じロジック
  def seed( id_in_db , operation_day_id )
    raise "Error: #{self.class.name}\##{__method__}"
    self.each do | station_time |
      station_time.seed( id_in_db , operation_day_id )
    end
  end
=end

  def stopping_stations
    self.map( &:station )
  end

  def stations
    stopping_stations.map( &:values ).flatten
  end

  [
    [ :stops_at? , :any? ] ,
    [ :station_time_info_of , :find ] ,
    [ :index_of , :index ]
  ].each do | defined_method_name , used_method_name |
    eval <<-DEF
      def #{ defined_method_name }( station_same_as )
        self.#{ used_method_name }( &proc_for_deciding_place( station_same_as ) )
      end
    DEF
  end

  def station_time_info_and_index_of( station_same_as )
    {
      station_time_in_train_timetable: station_time_info_of( station_same_as ) ,
      index_in_train_timetable: index_of( station_same_as ) ,
    }
  end

  private

  def proc_for_deciding_place( station_same_as )
    ::Proc.new { | station_time | station_time.is_at?( station_same_as ) }
  end

end