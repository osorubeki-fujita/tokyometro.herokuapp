module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::LocatedArea

  def inside?
    located_area_name_ja == "改札内"
  end

  def outside?
    located_area_name_ja == "改札外"
  end

end