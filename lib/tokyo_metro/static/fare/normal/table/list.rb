# 各料金区間の運賃の配列
class TokyoMetro::Static::Fare::Normal::Table::List < Array

  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::List

  # 運賃の配列を文字列として返すメソッド
  # @param indent [Integer (>0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    str_ary = ::Array.new
    str_ary << self.class.header( indent )
    self.each do | fare |
      str_ary << fare.to_s_in_a_row( indent )
    end
    str_ary.join( "\n" )
  end
  alias :to_strf :to_s

  # 運賃情報の整数の列が与えられたときに、配列 (self) から該当する要素を抜き出して返すメソッド
  # @param ticket_fare [Integer] 普通運賃（大人・切符）
  # @param child_ticket_fare [Integer] 普通運賃（小児・切符）
  # @param ic_card_fare [Integer] 普通運賃（大人・ICカード）
  # @param child_ic_card_fare [Integer] 普通運賃（小児・ICカード）
  # @return [Pattern]
  def select_fare( ticket_fare , child_ticket_fare , ic_card_fare , child_ic_card_fare )
    self.each do |i|
      if i.match?( ticket_fare , child_ticket_fare , ic_card_fare , child_ic_card_fare )
        return i
      end
    end
    nil
  end

  # 運賃の情報を出力する際のヘッダー
  # @param indent [Integer (>0)] インデントの幅
  # @return [String]
  def self.header( indent = 0 )
    [ "Ticket" , "Ticket (Child)" , "IC Card" , "IC Card (Child)" ].map{ | i | i.ljust(16) }.join( " " * 8 )
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_normal_table_list
  end

end