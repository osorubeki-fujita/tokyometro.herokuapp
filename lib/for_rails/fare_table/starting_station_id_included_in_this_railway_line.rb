# 運賃表を作成する際に、自駅を取得するモジュール
# @note
#   このモジュールは、{FareTableHelper#fare_table_of_each_railway_line} の内部で {RailwayLine} のインスタンスに include される。
#   このモジュールのメソッドは、{RailwayLine} のインスタンスの特異メソッドとなる。
module ForRails::FareTable::StartingStationIdIncludedInThisRailwayLine

  # stations_of_this_instance は、駅（路線）のインスタンスとする。
  #   また、self は (model) RailwayLine のインスタンスとする。
  #   路線のインスタンス self に、stations_of_this_instance の要素である駅（路線別）と同名の駅が含まれている場合は、その駅の id を返す。
  #   含まれていない場合は、nil を返す。
  # @param stations_of_this_instance 駅（路線）のインスタンス
  # @return [Integer or nil]
  def fare_table_starting_station_id_included_in_this_railway_line( stations_of_this_instance )
    ids_of_stations = stations_of_this_instance.pluck( :id )
    ids_of_this_railway_line = self.stations.pluck( :id )
    ary = ( ids_of_stations & ids_of_this_railway_line )
    if ary.empty?
      nil
    elsif ary.length == 1
      ary.first
    else
      raise "Error"
    end
  end

end