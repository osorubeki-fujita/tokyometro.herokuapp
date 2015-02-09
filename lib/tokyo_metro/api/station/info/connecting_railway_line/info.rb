class TokyoMetro::Api::Station::Info::ConnectingRailwayLine::Info < TokyoMetro::Api::Station::Info::Common::Info

  def initialize( railway_line )
    @railway_line = railway_line
  end

  attr_reader :railway_line

  def self.factory_for_this_class
    factory_for_generating_connecting_railway_from_string
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_connecting_railway_line_info
  end

end