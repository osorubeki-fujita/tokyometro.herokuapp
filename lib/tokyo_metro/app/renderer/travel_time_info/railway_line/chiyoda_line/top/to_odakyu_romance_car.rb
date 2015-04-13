class TokyoMetro::App::Renderer::TravelTimeInfo::RailwayLine::ChiyodaLine::Top::ToOdakyuRomanceCar < TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType

  def initialize( request )
    super( request )

    @train_type = ::TrainType.find_by( same_as: "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal" )
    @railway_line_and_terminal_station_info = [
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
        @request ,
        ::RailwayLine.find_by( same_as: "odpt.Railway:Odakyu.Tama" ) ,
        ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Tama.Karakida" )
      ) ,
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
        @request ,
        ::RailwayLine.find_by( same_as: "odpt.Railway:Odakyu.Odawara" ) ,
        ::Station::Info.find_by( same_as: "odpt.Station:Odakyu.Odawara.HonAtsugi" )
      ) ,
      ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::ThroughOperation::EachType::RailwayLineAndTerminalStation.new(
        @request ,
        ::RailwayLine.find_by( same_as: "odpt.Railway:HakoneTozan.Rail.OdawaraSide" ) ,
        ::Station::Info.find_by( same_as: "odpt.Station:HakoneTozan.Rail.HakoneYumoto" )
      )
    ]
  end

end