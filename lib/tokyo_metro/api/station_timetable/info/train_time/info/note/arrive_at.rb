# 到着ホームの情報を扱うクラス
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ArriveAt

  # Constructor
  # @param sta [String] 到着駅
  # @param number [Integer] 到着ホーム
  def initialize( sta , number )
    @station = sta
    @number = number
  end

  # @return [String] 到着駅
  attr_reader :station
  # @return [Integer] 到着ホーム
  attr_reader :number
  alias :sta :station

  # 自身の情報を文字列に変換して返すメソッド
  # @return [String]
  def to_s
    "#{@station}では#{@number}番線に到着"
  end

  # 他のインスタンスとの比較に使用するメソッド
  # @param other_instance [ArriveAt] 比較対象のインスタンス
  # @return [Integer]
  def <=>( other_instance )
    if @station == other_instance.station
      if @number == other_instance.number
        0
      else
        @number <=> other_instance.number
      end
    else
      @station <=> other_instance.station
    end
  end

  def seed_and_get_id( railway_line_ids )
    station_in_db = ::Station.find_by( name_ja: @station , railway_line_id: railway_line_ids )
    h = {
      station_id: station_in_db.id ,
      platform_number: @number
    }
    ::TrainTimetableArrivalInfo.find_or_create_by(h).id
  end

  # 複数の定数を定義するメソッド
  # @return [nil]
  def self.set_constants
    set_constant( :ASAKUSA , "浅草" , 1 , 2 )
    return nil
  end

  # 駅名と到着ホームからインスタンスを取得するメソッド
  # @param str [String] 駅名
  # @param i [Integer] 到着ホーム
  # @return [ArriveAt]
  def self.set_from_string( str , i )
    case str
    when "浅草"
      ASAKUSA[i]
    else
      raise "Error"
    end
  end

  class << self

    private

    def set_constant( const_name , sta , min_i , max_i )
      h = Hash.new
      ( min_i..max_i ).each do |i|
        h[i] = self.new( sta , i )
      end
      const_set( const_name , h )
    end

  end

end