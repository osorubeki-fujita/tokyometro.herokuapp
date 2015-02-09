# 駅間の標準所要時間リストの配列
class TokyoMetro::Api::RailwayLine::Info::TravelTime::List < TokyoMetro::Api::RailwayLine::Info::MetaClass::List

  def self.factory_for_seeding_this_class
    factory_for_seeding_travel_time_infos_in_each_railway_line
  end

end