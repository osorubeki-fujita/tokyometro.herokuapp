class TokyoMetro::Api::Station::Info::Common::List < TokyoMetro::Api::MetaClass::Fundamental::List

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def seed( station_id , indent )
    super( station_id , indent: indent + 1 , not_on_the_top_layer: true , no_display: true , display_number: false )
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 0 )
  end

end