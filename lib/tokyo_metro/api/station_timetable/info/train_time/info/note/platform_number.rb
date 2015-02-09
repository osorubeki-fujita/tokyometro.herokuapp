# 出発ホームの情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::PlatformNumber

  # Constructor
  # @param number [Integer] 出発ホーム
  def initialize( number )
    @number = number
  end

  # @return [Integer] 出発ホーム
  attr_reader :number

  # 自身の情報を文字列に変換して返すメソッド
  # @return [String]
  def to_s
    "#{@number}番線発"
  end

  # 他のインスタンスとの比較に使用するメソッド
  # @param other_instance [PlatformNumber] 比較対象のインスタンス
  # @return [Integer]
  def <=>( other_instance )
    @number <=> other_instance.number
  end

  # 定数 ARRAY を定義するメソッド
  # @return [nil]
  def self.set_constant
    h = Hash.new
    ( 1..10 ).each do |i|
      h[i] = self.new( i )
    end
    self.const_set( :LIST , h )
    return nil
  end

  # 出発ホームからインスタンスを取得するメソッド
  # @param i [Integer] 出発ホーム
  # @return [PlatformNumber]
  def self.set_from_string( i )
    LIST[i]
  end

end