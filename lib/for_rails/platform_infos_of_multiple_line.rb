module ForRails::PlatformInfosOfMultipleLine

  def platform_infos_of_yurakucho_and_fukutoshin_line?( station_facility )
    platform_infos_of_multiple_line?( *( ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_same_as ) ) and between_wakoshi_and_kotake_mukaihara?( station_facility )
  end

  def platform_infos_of_namboku_and_toei_mita_line?( station_facility )
    platform_infos_of_namboku_line? and between_meguro_and_shirokane_takanawa?( station_facility )
  end

  private

  def platform_infos_of_namboku_line?
    platform_infos_of_multiple_line?( "odpt.Railway:TokyoMetro.Namboku" )
  end

  def platform_infos_of_multiple_line?( *ary )
    self.keys.sort.map { | railway_line_id | ::RailwayLine.find( railway_line_id ).same_as } == ary
  end

  def between_wakoshi_and_kotake_mukaihara?( station_facility )
    ary = ::TokyoMetro::CommonModules::Dictionary::Station::StringList.between_wakoshi_and_kotake_mukaihara_in_system
    between_specific_stations?( station_facility , ary )
  end

  def between_meguro_and_shirokane_takanawa?( station_facility )
    ary = ::TokyoMetro::CommonModules::Dictionary::Station::StringList.namboku_and_toei_mita_line_common_stations_in_system
    between_specific_stations?( station_facility , ary )
  end

  def between_specific_stations?( station_facility , station_ary )
    station_ary.map { | station | "odpt.StationFacility:TokyoMetro.#{station}" }.include?( station_facility.same_as )
  end

end