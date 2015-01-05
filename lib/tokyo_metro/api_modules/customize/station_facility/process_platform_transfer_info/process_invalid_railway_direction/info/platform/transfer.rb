module TokyoMetro::ApiModules::Customize::StationFacility::ProcessPlatformTransferInfo::ProcessInvalidRailwayDirection::Info::Platform::Transfer

  def initialize( railway_line , railway_direction , necessary_time )
    super
    process_invalid_railway_direction
  end

  private

  def process_invalid_railway_direction
    if @railway_direction == "odpt.Railway:Toei.Shinjuku"
      @railway_direction = "odpt.RailDirection:Toei.Shinjuku"
      puts "修正：半蔵門線九段下駅 乗換情報"
    end
  end

end