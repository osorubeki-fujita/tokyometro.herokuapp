# 各駅の乗降者数の配列
class TokyoMetro::Api::PassengerSurvey::List < TokyoMetro::Api::MetaClass::NotRealTime::List

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

  # 乗降客数でソートするメソッド
  # @return [List]
  def sort_by_passenger_journeys
    self.class.new( self.sort_by( &:passenger_journeys ) )
  end

# 配列を逆順にするメソッド
  # @return [List]
  def reverse
    ary = super
    self.class.new( ary )
  end

  # 調査年度を選択するメソッド
  # @param year_n [::Array <Integer (year)>] 調査年度
  # @return [List]
  def select_year( *year_n )
    self.class.new( self.select { | station |
      year_n.include?( station.survey_year )
    } )
  end

  def seed
    super( ::Operator.all )
  end

end