module TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::StationInfos

  def self.make_group_from( request , station_infos , fares , normal_fare_groups )
    ::TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::StationInfos::GroupList::Factory.new( request , station_infos , fares , normal_fare_groups ).to_a
  end

end