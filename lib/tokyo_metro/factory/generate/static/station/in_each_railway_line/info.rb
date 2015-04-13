class TokyoMetro::Factory::Generate::Static::Station::InEachRailwayLine::Info < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal

  include ::TokyoMetro::ClassNameLibrary::Static::Station

  def self.hash_keys
    [
      :station_name_alias , :station_facility , :station_facility_custom , :station_facility_custom_alias ,
      :name_ja , :name_hira , :name_in_system , :name_en , :station_code ,
      :administrator , :other_operator , :stop ,
      :some_trains_stop , :stop_for_drivers
    ]
  end

  def initialize( same_as , h , index_in_railway_line = nil )
    super( same_as , h )
    @index_in_railway_line = index_in_railway_line
  end

  private

  def variables
    super + [ @index_in_railway_line ]
  end

end