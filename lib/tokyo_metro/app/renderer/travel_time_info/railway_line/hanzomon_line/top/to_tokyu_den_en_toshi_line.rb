class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::HanzomonLine::Top::ToTokyuDenEnToshiLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @direction = [
      ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.DenEnToshi.FutakoTamagawa" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.DenEnToshi.Nagatsuta" )
    ]
    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by_same_as( "odpt.Railway:Tokyu.DenEnToshi" ) ,
      ::Station::Info.find_by_same_as( "odpt.Station:Tokyu.DenEnToshi.ChuoRinkan" )
    )
  end

end