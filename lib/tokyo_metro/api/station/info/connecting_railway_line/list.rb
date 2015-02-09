# 乗り換え可能路線の一覧を扱うクラス
class TokyoMetro::Api::Station::Info::ConnectingRailwayLine::List < TokyoMetro::Api::Station::Info::Common::List

  def self.factory_for_seeding_this_class
    factory_for_seeding_connecting_railway_lines_of_each_station
  end

  def set_index_in_station!
    self.each.with_index(1) do | connecting_railway_line , i |
      connecting_railway_line.send( :set_index_in_station , i )
    end
    return self
  end

  def sort!
    self.sort_by!( &:index_in_station )
  end

  def railway_lines
    self.map( &:railway_line )
  end

end