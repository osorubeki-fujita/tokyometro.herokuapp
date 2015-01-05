# 各種施設の配列
class TokyoMetro::Api::StationFacility::Info::BarrierFree::List < TokyoMetro::Api::MetaClass::Fundamental::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 1 )
  end

  def seed( station_facility_id , indent: 0 )
    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ , indent: indent )
    time_begin = Time.now

    self.each do | facility |
      facility.seed( station_facility_id )

      facility_id = facility.instance_in_db.id
      facility.seed_place_name_info( facility_id )
      facility.seed_additional_info( facility_id )
      puts ""
      puts "Complete: #{facility.same_as}"
      puts ""
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin , indent: indent )
  end

end