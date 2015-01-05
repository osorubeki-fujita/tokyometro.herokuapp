module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::ConvertRailwayLine

  private

  def convert_railway_instance_to_yurakucho_line
    @railway_line_instance = ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Yurakucho" )
  end

  def convert_railway_instance_to_fukutoshin_line
    @railway_line_instance = ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Fukutoshin" )
  end

end