module TokyoMetro::Modules::Api::Convert::Patches::StationFacility::RailwayDirectionInPlatformTransferInfo::Info::Platform::Info::Transfer::Info

  def initialize( railway_line , railway_direction , necessary_time )
    super
    process_invalid_railway_direction
  end

  private

  def process_invalid_railway_direction
    if @railway_direction == "odpt.Railway:Toei.Shinjuku"
      @railway_direction = "odpt.RailDirection:Toei.Shinjuku"
    end
  end

end