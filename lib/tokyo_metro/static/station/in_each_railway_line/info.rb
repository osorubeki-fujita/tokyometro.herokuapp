# 個別の路線の、個別の駅の情報を扱うクラス
class TokyoMetro::Static::Station::InEachRailwayLine::Info

  include ::TokyoMetro::ClassNameLibrary::Static::Station
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  # Constructor
  def initialize( same_as , station_name_alias , station_facility , station_facility_custom , station_facility_custom_alias ,
      name_ja , name_hira , name_in_system , name_en , station_code , 
      administrator , other_operator , stop ,
      some_trains_stop , stop_for_drivers ,
      index_in_railway_line )
    @same_as = same_as
    @station_name_alias = station_name_alias

    @station_facility = station_facility
    @station_facility_custom = station_facility_custom
    @station_facility_custom_alias = station_facility_custom_alias

    @name_ja = name_ja
    @name_hira = name_hira
    @name_in_system = name_in_system
    @name_en = name_en
    @station_code = station_code

    @index_in_railway_line = index_in_railway_line

    @administrator = administrator
    @other_operator = other_operator

    @stop = stop
    @some_trains_stop = some_trains_stop
    @stop_for_drivers = stop_for_drivers
  end

  # @return [String, ::Array or nil]
  attr_reader :station_name_alias

  # @return [String]
  attr_reader :station_facility
  # @return [String or nil]
  attr_reader :station_facility_custom
  # @return [String, ::Array or nil]
  attr_reader :station_facility_custom_alias

  # @return [String]
  attr_reader :name_ja
  # @return [String]
  attr_reader :name_hira
  # @return [String]
  attr_reader :name_in_system
  # @return [String]
  attr_reader :name_en

  # @return [String or nil]
  attr_reader :station_code

  # @return [Integer]
  attr_reader :index_in_railway_line

  # @return [String, ::Array or nil]
  attr_reader :administrator
  # @return [String, ::Array or nil]
  attr_reader :other_operator

  # @return [::Array]
  attr_reader :stop
  # @return [::Array or nil]
  attr_reader :some_trains_stop
  # @return [::Array or nil]
  attr_reader :stop_for_drivers

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    @same_as <=> other.same_as
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    str_1 = self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)

      if val.instance_of?( ::Array )
        val = val.join("／")
      else
        val = val.to_s
      end

      " " * indent + k + val
    }.join( "\n" )

    [ "=" * 96 , str_1 ].join( "\n" )
  end

  # 特定の列車種別の停車駅か否かを判定するメソッド
  # @return [Boolean]
  def stop_of?( train_type )
    @stop.include?( train_type )
  end

  def seed( railway_line_id )
    super( railway_line_id )
  end

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param h [Hash] ハッシュ
  # @return [Info]
  def self.generate_from_hash( same_as , h , index_in_railway_line = nil )
    super( same_as , h , index_in_railway_line )
  end

# @!endgroup

# @!group 駅の ID に関するメソッド

  # @return [String] 駅の ID キー-*
  attr_reader :same_as

# @!endgroup

end