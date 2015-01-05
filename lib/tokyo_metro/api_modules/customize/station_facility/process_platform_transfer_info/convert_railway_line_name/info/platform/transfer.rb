module TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ConvertRailwayLineName::Info::Platform::Transfer

  def initialize( railway_line , railway_direction , necessary_time )
    super
    convert_railway_line_name
  end

  private

  def convert_railway_line_name
    if @railway_line == "odpt.Railway:Tobu.Isesaki"
      @railway_line = "odpt.Railway:Tobu.SkyTreeIsesaki"
    end
  end

end