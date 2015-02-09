# 東京メトロの運賃表（普通運賃）を扱うクラス
# @note 運賃改定などを考慮し、複数の運賃表（改定前と改定後など）を格納することもできる。
class TokyoMetro::Static::Fare::Normal

  include ::Singleton
  include ::TokyoMetro::ClassNameLibrary::Static::Fare

  # Constructor
  def initialize
    @tables = ::Array.new
    @tables << self.class.normal_fare_table_class.generate_from_yaml( "Fare" , "20140401_normal" , self.class.static_toplevel_namespace.last_revision ).freeze
  end

  # データベースをもとにした運賃表（現在）
  # @return [::Array <::TokyoMetro::Static::Fare::Normal::Table>]
  attr_reader :tables

  # 指定された日付の運賃表を取得するメソッド
  # @note 運賃改定前後に使うことを念頭に、あらかじめ定義しておく。
  # @return [Table]
  def as_of( date = ::TokyoMetro.time_now )
    @tables.select { | table | date >= table.valid_from }.min { | a , b | a.valid_from <=> b.valid_from }
  end

  def current_faretable
    table = self.as_of
    raise "Error" if table.nil?
    return table
  end

  # @!group 自身の情報を変換して取得するメソッド

  # 自身の情報を配列にして返すメソッド
  # @return [::Array]
  def to_a
    @tables
  end

  # 自身の情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = ::Hash.new
    self.to_a.each do | table |
      h[ table.title.intern ] = table.list
    end
    h
  end

  # 自身の情報を文字列にして返すメソッド
  # @param indent [Integer (>0)] インデントの幅
  # @return [Hash]
  def to_s( indent = 0 )
    str_ary = ::Array.new
    self.to_a.each do | table |
      str_ary << table.to_s( indent + 2 )
    end
    str_ary.join( "\n" * 2 )
  end

  def self.seed
    self.instance.current_faretable.seed
  end

  # @!endgroup

  def self.test
    puts self.instance.current_faretable.to_s
  end

end