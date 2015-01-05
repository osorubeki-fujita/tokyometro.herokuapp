# 各路線の情報の配列
class TokyoMetro::Api::RailwayLine::List < TokyoMetro::Api::MetaClass::Hybrid::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 3 )
  end

  def sort_by_railway_line_order
    self.class.new( self.sort_by { | railway_line | ::TokyoMetro::StaticDatas.railway_lines[ railway_line.same_as ].order } )
  end

  # @note {TokyoMetro::Api::RailwayLine::Info#seed_index_of_stations} を実行。
  # @note 使用停止中。
  def seed_index_of_stations
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ )
    time_begin = Time.now

    self.each do | info |
      info.seed_index_of_station
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin )
  end

  def seed_travel_time_infos
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ )
    time_begin = Time.now

    self.each do | info |
      info.seed_travel_time_info
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin )
  end

  def seed_women_only_car_infos
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ )
    time_begin = Time.now

    self.each do | info |
      info.seed_women_only_car_info
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin )
  end

end