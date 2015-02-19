# 個別の駅の乗降者数を扱うクラス
class TokyoMetro::Api::PassengerSurvey::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Api::Info::ToStringGeneral

  # Constructor
  def initialize( id_urn , same_as , operator , survey_year , passenger_journeys )
    @id_urn = id_urn
    @same_as = same_as
    @operator = operator
    @survey_year = survey_year
    @passenger_journeys = passenger_journeys
  end

  # 固有識別子
  # @return [String]
  # @note 命名ルールは「odpt.PassengerSurvey:TokyoMetro.駅名.調査年」
  # @example
  #  odpt:PassengerSurvey:TokyoMetro.Tokyo.2013
  attr_reader :same_as

  # 運行会社
  # @return [String]
  attr_reader :operator

  # 調査年度
  # @return [Integer]
  attr_reader :survey_year

  # 駅の1日あたりの平均乗降人員数
  # @return [Integer]
  attr_reader :passenger_journeys

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "owl:sameAs" , @same_as )
    set_data_to_hash( h , "odpt:operator" , @operator )
    set_data_to_hash( h , "odpt:surveyYear" , @survey_year )
    set_data_to_hash( h , "odpt:passengerJourneys" , @passenger_journeys )

    h
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    str_ary = ::Array.new
    str_ary << "\[#{self.class.rdf_type}\] #{@same_as}"
    str_ary << ""
    h = self.to_h
    h[ "odpt:passengerJourneys" ] = h[ "odpt:passengerJourneys" ].to_currency
    h.each do | key , value |
      str_ary << ( " " * 2 + key.ljust(32) + value.to_s )
    end
    str_ary.map { | str | " " * indent + str }.join( "\n" )
  end

  alias :to_strf :to_s

end