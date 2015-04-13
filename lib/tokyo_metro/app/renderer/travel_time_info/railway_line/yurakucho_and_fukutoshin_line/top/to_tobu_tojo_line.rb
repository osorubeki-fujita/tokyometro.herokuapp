class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::YurakuchoAndFukutoshinLine::Top::ToTobuTojoLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @from_station = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Yurakucho.Wakoshi" )
    # @from_station = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi" )

    @direction = [
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.Tojo.Shiki" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.Tojo.Kawagoe" )
    ]

    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by( same_as: "odpt.Railway:Tobu.Tojo" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tobu.Tojo.ShinrinKoen" )
    )
  end

end