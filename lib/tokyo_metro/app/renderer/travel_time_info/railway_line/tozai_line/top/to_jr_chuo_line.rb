class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::TozaiLine::Top::ToJrChuoLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by( same_as: "odpt.Railway:JR-East.ChuoSobu" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:JR-East.ChuoTozai.Mitaka" )
    )
  end

end