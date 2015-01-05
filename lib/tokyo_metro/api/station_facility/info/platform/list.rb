# 施設・出口などの情報の配列
class TokyoMetro::Api::StationFacility::Info::Platform::List < TokyoMetro::Api::MetaClass::Fundamental::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 1 )
  end

  def seed( station_facility_id , whole: nil , now_at: nil )
    indent_default = 1

    ::TokyoMetro::Seed::Inspection.title_with_method( self.class , __method__ , indent: indent_default , whole: whole , now_at: now_at )
    time_begin = ::Time.now

    self.each do | info |
      info.seed( station_facility_id , indent: indent_default + 1 )
    end

    ::TokyoMetro::Seed::Inspection.time( time_begin , indent: indent_default )
  end

end