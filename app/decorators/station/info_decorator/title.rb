
__END__

class Station::InfoDecorator::Title < TokyoMetro::Factory::Decorate::AppSubDecorator

  def link_to_station_page
    ::Station::InfoDecorator::Title::LinkToStationPage.new( @decorator )
  end

end
