# 運賃のパターン（各料金区間の運賃）を扱うクラス (Struct)
# @attr ticket_fare [Integer] 普通運賃（大人・切符）
# @attr child_ticket_fare [Integer] 普通運賃（小児・切符）
# @attr ic_card_fare [Integer] 普通運賃（大人・ICカード）
# @attr child_ic_card_fare [Integer] 普通運賃（小児・ICカード）
class TokyoMetro::StaticDatas::Fare::Normal::Table::Pattern < ::Struct.new( :ticket_fare , :child_ticket_fare , :ic_card_fare , :child_ic_card_fare )

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Fare

  # 普通運賃（大人・切符）
  # @return [Integer]
  def ticket_fare
    self[ :ticket_fare ]
  end

  # 普通運賃（小児・切符）
  # @return [Integer]
  def child_ticket_fare
    self[ :child_ticket_fare ]
  end

  # 普通運賃（大人・ICカード）
  # @return [Integer]
  def ic_card_fare
    self[ :ic_card_fare ]
  end

  # 普通運賃（小児・ICカード）
  # @return [Integer]
  def child_ic_card_fare
    self[ :child_ic_card_fare ]
  end

  # @!group 運賃の情報を出力するメソッド

  # 各種運賃を配列として返すメソッド
  # @return [::Array]
  def to_a
    [ self.ticket_fare , self.child_ticket_fare , self.ic_card_fare , self.child_ic_card_fare ]
  end

  # 運賃の情報を1行で出力するメソッド（簡易版）
  # @param indent [Integer (>0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    " " * indent + self.to_a.map { | i | i.to_currency.rjust(16) }.join( " " * 8 )
  end

  # 運賃の情報を1行で出力するメソッド（詳細版）
  # @param indent [Integer (>0)] インデントの幅
  # @param header [Boolean] ヘッダーを表示するか否かの設定
  # @return [String]
  def to_s_in_a_row( indent = 0 , header: false )
    str_ary = ::Array.new
    if header
      header_str = self.class.header( indent )
      str_ary << ( " " * indent + header_str.gsub( / +\Z/ , "" ) )
    end
    fare = self.to_s

    str_ary << ( " " * indent + fare )
    str_ary.join( "\n" )
  end

  # 運賃の情報を表にして出力するメソッド
  # @param indent [Integer (>0)] インデントの幅
  # @return [String]
  def to_s_table( indent = 0 )
    str_ary = ::Array.new
    row_1 = ::Array.new
    row_2 = ::Array.new

    row_1 << ( "odpt:ticketFare".ljust(24) + self.ticket_fare.to_currency.rjust(8) )
    row_1 << ( "odpt:childTicketFare".ljust(24) + self.child_ticket_fare.to_currency.rjust(8) )
    row_2 << ( "odpt:icCardFare".ljust(24) + self.ic_card_fare.to_currency.rjust(8) )
    row_2 << ( "odpt:childIcCardFare".ljust(24) + self.child_ic_card_fare.to_currency.rjust(8) )

    [ row_1 , row_2 ].each do | row |
      str_ary << " " * indent + row.join( " " * 8 )
    end
    str_ary.join( "\n" )
  end

  # @!group データの判定

  # 運賃の情報が与えられたときに、self と一致するか否かを判定するメソッド
  # @param ticket_fare [Integer] 普通運賃（大人・切符）
  # @param child_ticket_fare [Integer] 普通運賃（小児・切符）
  # @param ic_card_fare [Integer] 普通運賃（大人・ICカード）
  # @param child_ic_card_fare [Integer] 普通運賃（小児・ICカード）
  # @return [Boolean]
  def match?( ticket_fare , child_ticket_fare , ic_card_fare , child_ic_card_fare )
    self.to_a == [ ticket_fare , child_ticket_fare , ic_card_fare , child_ic_card_fare ]
  end

  # @!group 回数券 (1) - 発売額

  # 回数券（大人）の発売額
  # @return [Integer]
  def coupon_ticket_fare
    self[ :ticket_fare ] * 10
  end

  # 回数券（小児）の発売額
  # @return [Integer]
  def child_coupon_ticket_fare
    self[ :child_ticket_fare ] * 10
  end

  # @!group 回数券 (2) - 1枚あたりの発売額

  # 普通回数券（大人・11枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def normal_coupon_ticket_per_one_piece
    coupon_ticket_fare_per_one_piece( :coupon_ticket_fare , 11 )
  end

  # 時差回数券（大人・12枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def daytime_coupon_ticket_per_one_piece
    coupon_ticket_fare_per_one_piece( :coupon_ticket_fare , 12 )
  end

  # 土休回数券（大人・14枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def holiday_coupon_ticket_per_one_piece
    coupon_ticket_fare_per_one_piece( :coupon_ticket_fare , 14 )
  end

  # 普通回数券（小児・11枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def child_normal_coupon_ticket_per_one_piece
    coupon_ticket_fare_per_one_piece( :child_coupon_ticket_fare , 11 )
  end

  # 時差回数券（小児・12枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def child_daytime_coupon_ticket_per_one_piece
    coupon_ticket_fare_per_one_piece( :child_coupon_ticket_fare , 12 )
  end

  # 土休回数券（小児・14枚つづり）の1枚あたりの発売額
  # @return [Integer]
  def child_holiday_coupon_ticket_per_one_piece
    coupon_ticket_fare_per_one_piece( :child_coupon_ticket_fare , 14 )
  end

  # @!endgroup

  def seed( date_of_revision , operator_id )
    h = ::Hash.new
    h[ :date_of_revision ] = date_of_revision
    h[ :operator_id ] = operator_id
    [ :ticket_fare , :child_ticket_fare , :ic_card_fare , :child_ic_card_fare ].each do | column |
      h[ column ] = self.send( column )
    end
    ::NormalFareGroup.create(h)
  end

  # @!group クラスメソッド

  # 運賃の情報を出力する際のヘッダー
  # @return [String]
  def self.header( indent )
    self.normal_fare_table_list_class.header( indent )
  end

  # @!endgroup

  private

  # 回数券の1枚あたりの発売額
  # @param method [Symbol] 呼び出すメソッドの名称
  # @param whole_pieces [Integer] 発売時の枚数
  # @return [Numeric]
  def coupon_ticket_fare_per_one_piece( method , whole_pieces )
    self.send( method ) * 1.0 / whole_pieces
  end

  # @!endgroup

end