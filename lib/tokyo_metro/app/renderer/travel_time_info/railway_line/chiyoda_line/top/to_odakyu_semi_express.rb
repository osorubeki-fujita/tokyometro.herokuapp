class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top::ToOdakyuSemiExpress < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @train_type = ::TrainType.find_by( same_as: "custom.TrainType:TokyoMetro.Chiyoda.SemiExpress.ForOdakyu" )
    @direction = [
      ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.SeijoGakuenMae" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.Noborito" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.ShinYurigaoka" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.Machida" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.Ebina" )
    ]
    @railway_line_and_terminal_station_info = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
        @request ,
      ::RailwayLine.find_by( same_as: "odpt.Railway:Odakyu.Odawara" ) ,
      ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.HonAtsugi" )
    )
  end

end