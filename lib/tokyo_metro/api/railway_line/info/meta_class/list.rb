class TokyoMetro::Api::RailwayLine::Info::MetaClass::List < ::TokyoMetro::Api::MetaClass::Fundamental::List

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  def seed( railway_line_id )
    super( railway_line_id , indent: 1 , not_on_the_top_layer: true , display_number: false , no_display: true )
  end

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 1 )
  end

end