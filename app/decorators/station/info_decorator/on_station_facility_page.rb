class Station::InfoDecorator::OnStationFacilityPage < TokyoMetro::Factory::Decorate::AppSubDecorator

  def railway_line_infos( request )
    ::Station::InfoDecorator::OnStationFacilityPage::RailwayLineInfos.new( @decorator , request )
  end

end
