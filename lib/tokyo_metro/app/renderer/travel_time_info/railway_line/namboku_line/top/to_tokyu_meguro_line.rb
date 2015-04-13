class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::NambokuLine::Top::ToTokyuMeguroLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @direction = [
      ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Meguro.Oookayama" ) ,
      ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Meguro.MusashiKosugi" )
    ]
    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by_same_as( "odpt.Railway:Tokyu.Meguro" ) ,
      ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.Meguro.Hiyoshi" )
    )
  end

end