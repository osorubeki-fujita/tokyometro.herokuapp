# 女性専用車両の情報のリスト（複数の情報）を扱う配列
class TokyoMetro::Api::RailwayLine::Info::WomenOnlyCar::List < TokyoMetro::Api::RailwayLine::Info::MetaClass::List

  def self.factory_for_seeding_this_class
    factory_for_seeding_women_only_car_infos_in_each_railway_line
  end

end