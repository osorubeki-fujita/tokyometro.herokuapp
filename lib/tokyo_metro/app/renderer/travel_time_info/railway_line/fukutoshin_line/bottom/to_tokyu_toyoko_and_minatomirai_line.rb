class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::FukutoshinLine::Bottom::ToTokyuToyokoAndMinatomiraiLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @direction = [
      ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.Toyoko.NakaMeguro" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.Toyoko.MusashiKosugi" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.Toyoko.Kikuna" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.Toyoko.Yokohama" )
    ]
    @via = ::RailwayLine.find_by( same_as: "odpt.Railway:Tokyu.Toyoko" )
    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by( same_as: "odpt.Railway:YokohamaMinatomiraiRailway.Minatomirai" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:YokohamaMinatomiraiRailway.Minatomirai.MotomachiChukagai" )
    )
  end

end