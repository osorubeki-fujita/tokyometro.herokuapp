class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Bottom::ToJrJobanLine < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @from_station = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Chiyoda.Ayase" )
    @direction = [
      ::Station::Info.find_by( same_as: "odpt.Station:JR-East.Joban.Matsudo" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:JR-East.Joban.Kashiwa" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:JR-East.Joban.Abiko" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:JR-East.Joban.Toride" )
    ]
    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
      @request ,
      ::RailwayLine.find_by( same_as: "odpt.Railway:JR-East.Joban" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:JR-East.Joban.Toride" )
    )
    @note ="取手までの直通運転は朝夕のみ、日中は我孫子まで"
  end

end