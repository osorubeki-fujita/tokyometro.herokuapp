
__END__

class Station::InfoDecorator::Title::LinkToStationPage < ::TokyoMetro::Factory::Decorate::AppSubDecorator

  def ja
    "#{ station_codes } #{ name_ja_actual } - #{ object.name_hira } (#{ object.name_en }) "
  end

  def en
    "#{ station_codes } #{ object.name_en } - #{ name_ja_actual } （#{ object.name_hira }）"
  end

  private

  def station_codes
    _station_codes = decorator.send( __method__ )
    "\[ #{ _station_codes.join(" , " ) } \]"
  end

end
