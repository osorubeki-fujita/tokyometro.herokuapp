# 2駅間の運賃を扱うクラス
class TokyoMetro::Api::Fare::Info < TokyoMetro::Api::MetaClass::NotRealTime::Info

  include ::TokyoMetro::ClassNameLibrary::Api::Fare
  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  # Constructor
  def initialize( id_urn , same_as , dc_date , operator , from_station , to_station , normal_fare )
    @id_urn = id_urn
    @same_as = same_as
    @dc_date = dc_date
    @operator = operator
    @from_station = from_station
    @to_station = to_station
    @normal_fare = normal_fare
  end

  # 固有識別子
  # @return [String]
  # @note 命名ルールは「odpt.RailwayFare:TokyoMetro.出発駅の路線名.出発駅名.TokyoMetro.到着駅の路線名.到着駅名」
  attr_reader :same_as

  # データ生成日時（ISO8601 日付時刻形式）
  # @return [String]
  attr_reader :dc_date

  # 運行会社
  # @return [String]
  attr_reader :operator

  # 駅間の始点駅
  # @return [String]
  attr_reader :from_station

  # 駅間の終点駅
  # @return [String]
  attr_reader :to_station

  # 運賃の情報を扱うインスタンス
  # @return [::TokyoMetro::Static::Fare::Normal::Pattern]
  attr_reader :normal_fare

  def from?( *stations )
    stations.flatten.include?( @from_station )
  end

  def to?( *stations )
    stations.flatten.include?( @to_station )
  end

  def from_or_to?( *stations )
    from?( *stations ) or to?( *stations )
  end

  alias :to :to_station
  alias :from :from_station

  alias :to_sta :to_station
  alias :from_sta :from_station

  alias :is_from? :from?
  alias :is_to? :to?
  alias :is_from_or_to? :from_or_to?

  # @!group 運賃の情報を取得するメソッド

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "\@id" , @id_urn )
    set_data_to_hash( h , "owl:sameAs" , @same_as )
    set_data_to_hash( h , "dc:date" , @dc_date.to_s )
    set_data_to_hash( h , "odpt:operator" , @operator )
    set_data_to_hash( h , "odpt:fromStation" , @from_station )
    set_data_to_hash( h , "odpt:toStation" , @to_station )

    set_data_to_hash( h , "odpt:ticketFare" , self.ticket_fare )
    set_data_to_hash( h , "odpt:childTicketFare" , self.child_ticket_fare )
    set_data_to_hash( h , "odpt:icCardFare" , self.ic_card_fare )
    set_data_to_hash( h , "odpt:childIcCardFare" , self.child_ic_card_fare )

    h
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>0)] インデントの幅
  # @return [String]
  def to_s ( indent = 0 )
    h = self.to_h
    hash_keys_ary_1 = [ "\@id" , "owl:sameAs" , "dc:date" ]
    hash_keys_ary_2 = [ "odpt:operator" , "odpt:fromStation" , "odpt:toStation" ]
    hash_keys_ary_3 = [ "odpt:ticketFare" , "odpt:childTicketFare" , "odpt:icCardFare" , "odpt:childIcCardFare" ]

    str_ary = ::Array.new
    str_ary << " " * indent + "#{@from_station} - #{@to_station}"
    str_ary << ""

    [ hash_keys_ary_1 , hash_keys_ary_2 ].each do | hash_keys_ary |
      hash_keys_ary.each do | key |
        if h[ key ].present?
          str_ary << ( " " * ( indent + 2 ) + key.ljust(32) + h[ key ].to_strf )
        end
      end
      str_ary << ""
    end

    str_ary << @normal_fare.to_s_table( indent + 2 )
    str_ary.join( "\n" )
  end

  alias :to_strf :to_s

  # @!group 具体的な運賃を取得するメソッド (1) - 普通運賃

  # 普通運賃（大人・切符）
  # @return [Integer]
  def ticket_fare
    @normal_fare.ticket_fare
  end

  # 普通運賃（小児・切符）
  # @return [Integer]
  def child_ticket_fare
    @normal_fare.child_ticket_fare
  end

  # 普通運賃（大人・ICカード）
  # @return [Integer]
  def ic_card_fare
    @normal_fare.ic_card_fare
  end

  # 普通運賃（小児・ICカード）
  # @return [Integer]
  def child_ic_card_fare
    @normal_fare.child_ic_card_fare
  end

  # @!group 具体的な運賃を取得するメソッド (2) - 回数券

  # 回数券（大人）の発売額
  # @return [Integer]
  def coupon_ticket_fare
    @normal_fare.coupon_ticket_fare
  end

  # 回数券（小児）の発売額
  # @return [Integer]
  def child_coupon_ticket_fare
    @normal_fare.child_coupon_ticket_fare
  end

  # 普通回数券（大人・11枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def normal_coupon_ticket_per_one_piece
    @normal_fare.normal_coupon_ticket_per_one_piece
  end

  # 時差回数券（大人・12枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def daytime_coupon_ticket_per_one_piece
    @normal_fare.daytime_coupon_ticket_per_one_piece
  end

  # 土休回数券（大人・14枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def holiday_coupon_ticket_per_one_piece
    @normal_fare.holiday_coupon_ticket_per_one_piece
  end

  # 普通回数券（小児・11枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def child_normal_coupon_ticket_per_one_piece
    @normal_fare.child_normal_coupon_ticket_per_one_piece
  end

  # 時差回数券（小児・12枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def child_daytime_coupon_ticket_per_one_piece
    @normal_fare.child_daytime_coupon_ticket_per_one_piece
  end

  # 土休回数券（小児・14枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def child_holiday_coupon_ticket_per_one_piece
    @normal_fare.child_holiday_coupon_ticket_per_one_piece
  end

  # @!endgroup

end