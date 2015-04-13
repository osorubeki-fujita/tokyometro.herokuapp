class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::HanzomonLine::Bottom::ToTobuLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @direction = [
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.SkyTree.KitaSenju" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.SkyTree.Koshigaya" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.SkyTree.Kasukabe" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.SkyTree.TobuDobutsuKoen" )
    ]
    @via = ::RailwayLine.find_by( same_as: "odpt.Railway:Tobu.SkyTree" )
    @railway_line_and_terminal_station_info = [
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
        @request ,
        ::RailwayLine.find_by( same_as: "odpt.Railway:Tobu.Isesaki" ) ,
        ::Station::Info.find_by( same_as: "odpt.Station:Tobu.Isesaki.Kuki" )
      ) ,
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
        @request ,
        ::RailwayLine.find_by( same_as: "odpt.Railway:Tobu.Nikko" ) ,
        ::Station::Info.find_by( same_as: "odpt.Station:Tobu.Nikko.MinamiKurihashi" )
      )
    ]
  end

end