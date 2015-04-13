class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Bottom::ToSaitamaRailwayLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @direction = [
      ::Station::Info.find_by_same_as( "odpt.Station:SaitamaRailway.SaitamaRailway.Hatogaya" ) ,
      ::Station::Info.find_by_same_as( "odpt.Station:SaitamaRailway.SaitamaRailway.HigashiKawaguchi" )
    ]
    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by( same_as: "odpt.Railway:SaitamaRailway.SaitamaRailway" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:SaitamaRailway.SaitamaRailway.UrawaMisono" )
    )
  end

end