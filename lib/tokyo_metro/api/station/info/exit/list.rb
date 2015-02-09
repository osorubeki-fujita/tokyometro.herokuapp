# 駅出入口を表すオブジェクトへのリンクの配列
class TokyoMetro::Api::Station::Info::Exit::List < TokyoMetro::Api::Station::Info::Common::List

  def include_info_of?( id_urn )
    self.any? { | item | item.point == id_urn }
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_exits_of_each_station
  end

end