# 駅出入口を表すオブジェクトへのリンクの配列
class TokyoMetro::Api::Station::Info::Exit::List < TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List

  def seed( station_id )
    self.each do | exit_id_urn |
      exit_id = ::Point.find_by( id_urn: exit_id_urn )
      ::StationPoint.create( point_id: exit_id , station_id: station_id )
    end
  end

end